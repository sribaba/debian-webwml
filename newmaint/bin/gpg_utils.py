# Utility functions for the GPG Signing Coordination page
# Copyright (C) 2002  Martin Michlmayr <tbm@cyrius.com>
# $Id$

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

import string
import pg

def print_place(db, place):
    q = db.query("SELECT begin, finish, city, country FROM places WHERE id = %s" % place)
    begin, finish, city, country = q.getresult()[0]

    if city:
        out = "%s, %s: " % (city, country)
    else:
        out = "%s: " % (country)

    if (not begin and not finish):
        out += "always";
    elif (begin and not finish):
        out += "starting on %s" % begin
    elif (not begin and finish):
        out += "until %s" % finish
    else:
        out += "%s to %s" % (begin, finish)

    return out

def print_all_places(db, email, prefix=""):
    out = []
    for place in get_places(db, email):
        out.append(prefix + print_place(db, place))
    return string.join(out, "\n")

def find_email(db, email):
    q = db.query("SELECT email FROM people WHERE email = '%s'" % email)
    if q.getresult():
        return 1

def get_owner(db, place):
    q = db.query("SELECT email FROM people, places WHERE people.id = places.who AND places.id = %s" % place)
    return q.getresult()[0][0]

def get_places(db, email):
    q = db.query("SELECT places.id FROM places, people WHERE people.id = places.who AND people.email = '%s' ORDER BY country, UPPER(city)" % email)
    return [x[0] for x in q.getresult()]

def get_name(db, email):
    if name_cache.has_key(email):
        return name_cache[email]
    q = db.query("SELECT forename, surname FROM people WHERE email = '%s'" % email)
    if q.getresult():
        ql = q.getresult()
        name_cache[email] = ql[0]
        return name_cache[email]
    else:
        return None, None

def find_name(db, email):
    if get_name(db, email)[0] and get_name(db, email)[1]:
        return 1

def get_firstname(db, email):
    return get_name(db, email)[0]

def get_lastname(db, email):
    return get_name(db, email)[1]

def get_fullname(db, email):
    return "%s %s" % (get_firstname(db, email), get_lastname(db, email))

def remove_place(db, place):
    db.query("DELETE FROM places WHERE id = %s" % place)


# main

name_cache = {}


# vim:set ts=4:
# vim:set expandtab:
# vim:set shiftwidth=4:
