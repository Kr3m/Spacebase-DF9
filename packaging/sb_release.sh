#!/bin/bash

DRY_RUN=
PKG_NAME="spacebase-df9"
PKG_VERSION=$1

GPG=$(which gpg)
GREP=$(which grep)
MD5SUM=$(which md5sum || which gmd5sum)
SHA1SUM=$(which sha1sum || which gsha1sum)
SHA256SUM=$(which sha256sum || which gsha256sum)

if [ -z "${PKG_VERSION}" ]; then
    echo "Usage: $0 <pkg-version>"
    exit 1
fi

# Function: bail
# ----------------------------------------------------------------------
# Print error message and return to top of source tree
top_src=$(pwd)
bail() {
    echo "Error: $*" 2>&1
    cd ${top_src}
}

# Function: die
# ----------------------------------------------------------------------
# Print error message and exit
die() {
    bail $*
    exit 1
}

# Function: sign_or_fail
# ----------------------------------------------------------------------
# Sign the given file, if any
# Output the name of the signature generated to stdout (all other output to
# stderr)
# Return 0 on success, 1 on fail
#
sign_or_fail() {
    if [ -n "$1" ]; then
	sig=$1.sig
	rm -f $sig
	$GPG -b $1 1>&2
	if [ $? -ne 0 ]; then
	    bail "failed to sign $1."
	    return 1
	fi
	echo $sig
    fi
    return 0
}

# Function: get_tag_range
# ----------------------------------------------------------------------
# Returns a string marking the start and end of our release period
get_tag_range() {
    tag_previous=$(git describe --abbrev=0 HEAD^ 2>/dev/null)
    if [ $? -ne 0 ]; then
	echo "Warning: unable to find a previous tag."
	echo "         perhaps a first release on this branch."
	echo "         Please check the commit history in the announce."
    fi
    echo "$tag_previous..$local_top_commit_sha"
}

# Function: tag_top_commit
# ----------------------------------------------------------------------
# If a tag exists with the the tar name, ensure it is tagging the top commit
# It may happen if the version set in configure.ac has been previously released
tag_top_commit() {
    tag_name=$1

    tagged_commit_sha=$(git rev-list --max-count=1 $tag_name 2>/dev/null)
    if [ $? -eq 0 ]; then
	# Check if the tag is pointing to the top commit
	if [ x"$tagged_commit_sha" != x"$remote_top_commit_sha" ]; then
	    remote_top_commit_descr=$(git log --oneline --max-count=1 $remote_top_commit_sha)
	    local_tag_commit_descr=$(git log --oneline --max-count=1 $tagged_commit_sha)
	    bail "the \"$tag_name\" already exists." \
		"This tag is not tagging the top commit." \
		"The top commit is: \"$remote_top_commit_descr\"" \
		"Tag \"$tag_name\" is tagging some other commit: \"$local_tag_commit_descr\""
	    return 1
	else
	    echo "Info: module already tagged with \"$tag_name\"."
	fi
    else
	# Tag the top commit with the tar name
	if [ x"$DRY_RUN" = x ]; then
	    git tag -s -m ${tag_name} ${tag_name}
	    if [ $? -ne 0 ]; then
		bail "unable to tag module with \"$tag_name\"."
		return 1
	    else
		echo "Info: module tagged with \"$tag_name\"."
	    fi
	else
	    echo "Info: skipping the commit tagging in dry-run mode."
	fi
    fi
    return 0
}

# Function: verify_no_local_changes
# ----------------------------------------------------------------------
# Checks that the top commit has been pushed to the remote
verify_no_local_changes() {
    upstream=$1

    # Obtain the top commit SHA which should be the version bump
    # It should not have been tagged yet (the script will do it later)
    local_top_commit_sha=$(git rev-list --max-count=1 HEAD)
    if [ $? -ne 0 ]; then
	bail "unable to obtain the local top commit id."
	return 1
    fi

    # Check that the top commit has been pushed to remote
    remote_top_commit_sha=$(git rev-list --max-count=1 $upstream)
    if [ $? -ne 0 ]; then
	bail "unable to obtain top commit from the remote repository."
	return 1
    fi
    if [ x"$remote_top_commit_sha" != x"$local_top_commit_sha" ]; then
	local_top_commit_descr=$(git log --oneline --max-count=1 $local_top_commit_sha)
	bail "the local top commit has not been pushed to the remote." \
	    "The local top commit is: \"$local_top_commit_descr\""
	return 1
    fi
    return 0
}

# Function: create_dist_tarball
# ----------------------------------------------------------------------
# Generate the distribution tarball, or die trying
# Return 0 on success, 1 on fail
create_dist_tarball() {
    tag_name=$1
    if [ -e Makefile ]; then
	# FIXME: Checkout $tag_name if necessary?

	# make dist
	echo "Info: running \"make $MAKE_DIST_CMD\" to create tarballs:"
	${MAKE} $MAKEFLAGS $MAKE_DIST_CMD > /dev/null
	if [ $? -ne 0 ]; then
            bail "\"$MAKE $MAKEFLAGS $MAKE_DIST_CMD\" failed."
	    return 1
	fi
    else
	# git archive
	tar_name="$PKG_NAME-$PKG_VERSION"
	tarbz2=$tar_name.tar.bz2
	tree=HEAD
	if [ x$DRY_RUN = x ]; then
	    tree_ish="tags/${tag_name}"
	fi
	echo "git archive --format=tar $tree --prefix=${tar_name}/ | bzip2 >${tarbz2}"
	git archive --format=tar $tree --prefix=${tar_name}/ | bzip2 >${tarbz2}
	if [ $? -ne 0 ]; then
	    bail "couldn't create archive"
	    return 1
	fi
	echo "Generated tarball for tags/${tag_name} as ${tarbz2}"
    fi
    return 0
}

# Function: sign_dist_tarballs
# ----------------------------------------------------------------------
# Finds and signs tarballs that were previously generated
sign_dist_tarballs() {
    # Find out the tarname
    targz=$tar_name.tar.gz
    tarbz2=$tar_name.tar.bz2
    tarxz=$tar_name.tar.xz
    [ -e $targz ] && ls -l $targz || unset targz
    [ -e $tarbz2 ] && ls -l $tarbz2 || unset tarbz2
    [ -e $tarxz ] && ls -l $tarxz || unset tarxz

    if [ -z "$targz" -a -z "$tarbz2" -a -z "$tarxz" ]; then
	bail "no compatible tarballs found."
	return 1
    fi

    # Sign
    gpgsignerr=0
    siggz="$(sign_or_fail ${targz})"
    gpgsignerr=$((${gpgsignerr} + $?))
    sigbz2="$(sign_or_fail ${tarbz2})"
    gpgsignerr=$((${gpgsignerr} + $?))
    sigxz="$(sign_or_fail ${tarxz})"
    gpgsignerr=$((${gpgsignerr} + $?))
    return $gpgsignerr
}

# Function: display_contribution_summary
# ----------------------------------------------------------------------
# Prints out percentages of who contributed what this release
#
display_contribution_summary() {
    tag_range=$1
    echo
    echo "Contributors for release $tag_range"

    statistics=$(git log --no-merges "$tag_range" | git shortlog --summary -n | cat)

    SAVEIFS=$IFS
    IFS=$(echo -en "\n\b")

    total=0
    for line in ${statistics}; do
	count=$(echo $line | cut -c1-6)
	total=$(( $total + $count ))
    done

    for line in ${statistics}; do
	count=$(echo $line | cut -c1-6)
	pct=$(( 100 * $count / $total ))
	echo "$line ($pct%)"
    done
    echo "Total commits: $total"

    IFS=$SAVEIFS
}

# Function: display_change_list
# ----------------------------------------------------------------------
# Print out the shortlog of changes for this release period
#
display_change_list() {
    tag_range=$1
    echo
    echo "Full list of changes:"
    git log --no-merges "$tag_range" | git shortlog | cat
}

# Function: push_tag
# ----------------------------------------------------------------------
# 
push_tag() {
    tag_name=$1
    remote_name=$2
    echo "Info: pushing tag \"$tag_name\" to remote \"$remote_name\":"
    git push $remote_name $tag_name
    if [ $? -ne 0 ]; then
	bail "Error: unable to push tag \"$tag_name\" to the remote repository." \
	    "       it is recommended you fix this manually and not run the script again"
	return 1
    fi
    return 0
}

#
# ----------------------------------------------------------------------
#

echo "Preparing release"

# Determine what is the current branch and the remote name
current_branch=$(git branch | $GREP "\*" | sed -e "s/\* //")
remote_name=$(git config --get branch.$current_branch.remote)
remote_branch=$(git config --get branch.$current_branch.merge | cut -d'/' -f3,4)
echo "Info: working off the \"$current_branch\" branch tracking the remote \"$remote_name/$remote_branch\"."

# Check top commit has been pushed
verify_no_local_changes "$remote_name/$remote_branch"
if [ $? -ne 0 ]; then
    die "local changes"
fi

# Construct the new tag
tag_name="v${PKG_VERSION}"

# Tag the release
tag_top_commit $tag_name
if [ $? -ne 0 ]; then
    die "unable to tag top commit"
fi

# Generate the tarball
tar_name="$PKG_NAME-$PKG_VERSION"
create_dist_tarball $tag_name $tar_name
if [ $? -ne 0 ]; then
    die "failed to create dist tarball."
fi

# Sign tarballs
sign_dist_tarballs $tar_name
if [ $? -ne 0 ]; then
    die "unable to sign at least one of the tarballs."
fi

# TODO: Upload the tarballs

# Push top commit tag to remote repository
if [ x$DRY_RUN = x ]; then
    push_tag $tag_name $remote_name
    if [ $? -ne 0 ]; then
	exit 1
    fi
else
    echo "Info: skipped pushing tag \"$tag_name\" to the remote repository \"$remote_name\" in dry-run mode."
fi

# Generate the announce e-mail
tag_range=$(get_tag_range)
display_contribution_summary $tag_range
display_change_list $tag_range
