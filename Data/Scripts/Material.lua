------------------------------------------------------------------------
-- The contents of this file are subject to the Common Public
-- Attribution License Version 1.0. (the "License"); you may not use
-- this file except in compliance with this License.  You may obtain a
-- copy of the License from the COPYING file included in this code
-- base. The License is based on the Mozilla Public License Version 1.1,
-- but Sections 14 and 15 have been added to cover use of software over
-- a computer network and provide for limited attribution for the
-- Original Developer. In addition, Exhibit A has been modified to be
-- consistent with Exhibit B.
--
-- Software distributed under the License is distributed on an "AS IS"
-- basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
-- the License for the specific language governing rights and
-- limitations under the License.
--
-- The Initial developer of the Original Code is Doublefine Productions Inc.
--
-- The initial developer of this file is Bryce Harrington
-- of Derelict Games.
--
-- The code in this file is the original work of Derelict Games,
-- authored by Bryce Harrington
--
-- Copyright (c) 2016 Bryce Harrington <bryce@bryceharrington.org>
-- All Rights Reserved.
------------------------------------------------------------------------

local tMaterial = {
    VALUETYPE_TEXTURE = 1,
    VALUETYPE_FLOAT   = 2,
    VALUETYPE_VEC2    = 3,
    VALUETYPE_VEC3    = 4,
    VALUETYPE_VEC4    = 5,
}

if MOAIMaterial then
    print("Using built-in MOAIMaterial from executable")
    print("VALUETYPE_TEXTURE = ", VALUETYPE_TEXTURE)
    print("VALUETYPE_FLOAT   = ", VALUETYPE_FLOAT)
    print("VALUETYPE_VEC2    = ", VALUETYPE_VEC2)
    print("VALUETYPE_VEC3    = ", VALUETYPE_VEC3)
    print("VALUETYPE_VEC4    = ", VALUETYPE_VEC4)
    return MOAIMaterial
else
    print("Using locally defined MOAIMaterial")
    return tMaterial
end

