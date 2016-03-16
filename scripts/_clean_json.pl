#!/usr/bin/perl

use strict;
use warnings;

use JSON::PP;
use Data::Dumper;

# Custom sorting for unit entry fields
my $unit_field_values = {
    "army" => 100,
    "sectorial" => 101,
    "isc" => 102,
    "name" => 103,
    "sharedAva" => 104,
    "image" => 105,
    "optionSpecific" => 106,

    "type" => 200,
    "imp" => 201,
    "irr" => 202,
    "cube" => 203,
    "hackable" => 204,

    "mov" => 300,
    "cc" => 301,
    "bs" => 302,
    "ph" => 303,
    "wip" => 304,
    "arm" => 305,
    "bts" => 306,
    "w" => 307,
    "wtype" => 308,
    "s" => 309,
    "ava" => 310,

    "code" => 400,
    "codename" => 401,
    "cost" => 402,
    "swc" => 403,
    "profile" => 404,
    "spec" => 405,
    "bsw" => 406,
    "ccw" => 407,
    "independent" => 408,

    "profiles" => 500,
    "childs" => 501,
};

sub sort_unit {
    if (!exists $unit_field_values->{$JSON::PP::a}) {
        die "Unknown field $JSON::PP::a";
    }
    if (!exists $unit_field_values->{$JSON::PP::b}) {
        die "Unknown field $JSON::PP::b";
    }

    return $unit_field_values->{$JSON::PP::a} cmp $unit_field_values->{$JSON::PP::b};
}

# Fields to be filtered
my $unit_filter_fields = [
    "note",
    "functions",
    "cbcode",
    "hiddenalias",
    "notFor",
];

# Custom sorting for cc skill fields
my $cc_field_values = {
    "name" => 100,
    "attack" => 101,
    "opponent" => 102,
    "damage" => 103,
    "burst" => 104,
    "type" => 105,
    "special" => 106,
};

sub sort_cc {
    if (!exists $cc_field_values->{$JSON::PP::a}) {
        die "Unknown field $JSON::PP::a";
    }
    if (!exists $cc_field_values->{$JSON::PP::b}) {
        die "Unknown field $JSON::PP::b";
    }

    return $cc_field_values->{$JSON::PP::a} cmp $cc_field_values->{$JSON::PP::b};
}

# Custom sorting for hacking skill fields
my $hacking_field_values = {
    "Hacking Devices" => 100,
    "Hacking Program Groups" => 101,
    "Hacking Programs" => 102,

    "name" => 200,
    "groups" => 201,
    "upgrades" => 203,

    "programs" => 300,

    "range" => 400,
    "att mod" => 401,
    "opp mod" => 402,
    "damage" => 403,
    "burst" => 404,
    "ammo" => 405,
    "target" => 406,
    "effect" => 407,
    "skill" => 408,
    "special" => 409,
    "hide_mods" => 410
};

sub sort_hacking {
    if (!exists $hacking_field_values->{$JSON::PP::a}) {
        die "Unknown field $JSON::PP::a";
    }
    if (!exists $hacking_field_values->{$JSON::PP::b}) {
        die "Unknown field $JSON::PP::b";
    }

    return $hacking_field_values->{$JSON::PP::a} cmp $hacking_field_values->{$JSON::PP::b};
}

# Custom sorting for color data
my $color_field_values = {
    "armies" => 100,
    "sectorials" => 101,

    "army" => 200,
    "name" => 201,
    "backgroundColor" => 202,
    "primaryColor" => 203,
    "secondaryColor" => 204,
};

sub sort_color {
    if (!exists $color_field_values->{$JSON::PP::a}) {
        die "Unknown field $JSON::PP::a";
    }
    if (!exists $color_field_values->{$JSON::PP::b}) {
        die "Unknown field $JSON::PP::b";
    }

    return $color_field_values->{$JSON::PP::a} cmp $color_field_values->{$JSON::PP::b};
}

# Custom sorting for merc data
my $merc_field_values = {
    "armies" => 100,
    "sectorials" => 101,

    "army" => 200,
    "name" => 201,
    "mercs" => 202,
};

sub sort_merc {
    if (!exists $merc_field_values->{$JSON::PP::a}) {
        die "Unknown field $JSON::PP::a";
    }
    if (!exists $merc_field_values->{$JSON::PP::b}) {
        die "Unknown field $JSON::PP::b";
    }

    return $merc_field_values->{$JSON::PP::a} cmp $merc_field_values->{$JSON::PP::b};
}

# Custom sorting for sectorial data
my $sectorial_field_values = {
    "army" => 200,
    "name" => 201,
    "abbr" => 202,
    "units" => 203,

    "ava" => 100,
    "isc" => 101,
    "linkable" => 102,
};

sub sort_sectorial {
    if (!exists $sectorial_field_values->{$JSON::PP::a}) {
        die "Unknown field $JSON::PP::a";
    }
    if (!exists $sectorial_field_values->{$JSON::PP::b}) {
        die "Unknown field $JSON::PP::b";
    }

    return $sectorial_field_values->{$JSON::PP::a} cmp $sectorial_field_values->{$JSON::PP::b};
}

my $sectorial_filter_fields = [
"functions",
];

# Custom sorting for merc data
my $specops_field_values = {
    "specopsisc" => 100,
    "attributeboost" => 101,
    "attributeboostcost" => 102,
    "attributeboostmax" => 103,
    "extraweapons" => 104,
    "extraspecs" => 105,

    "isc" => 200,
    "basemodels" => 201,
    "code" => 202,

    "cc" => 301,
    "bs" => 302,
    "ph" => 303,
    "wip" => 304,
    "arm" => 305,
    "bts" => 306,
    "w" => 307,
};

sub sort_specops {
    # This data file has dictionaries with miscellaneous strings.
    # Don't throw an error if both strings are unknown data.
    if (!exists $specops_field_values->{$JSON::PP::a} && !exists $specops_field_values->{$JSON::PP::b}) {
        return $JSON::PP::a cmp $JSON::PP::b;
    }

    if (!exists $specops_field_values->{$JSON::PP::a}) {
        die "Unknown field $JSON::PP::a";
    }
    if (!exists $specops_field_values->{$JSON::PP::b}) {
        die "Unknown field $JSON::PP::b";
    }

    return $specops_field_values->{$JSON::PP::a} cmp $specops_field_values->{$JSON::PP::b};
}

# Custom sorting for weapons data
my $weapon_field_values = {
  "name" => 100,
  "mode" => 101,
  "alt_profile" => 102,
  "burst" => 103,
  "ammo" => 104,
  "damage" => 105,

  "short_dist" => 200,
  "short_mod" => 201,
  "medium_dist" => 202,
  "medium_mod" => 203,
  "long_dist" => 204,
  "long_mod" => 205,
  "max_dist" => 206,
  "max_mod" => 207,

  "attr" => 301,
  "cc" => 302,
  "template" => 303,
  "suppressive" => 304,
  "uses" => 305,
  "note" => 306,
};
sub sort_weapon {
    if (!exists $weapon_field_values->{$JSON::PP::a}) {
        die "Unknown field $JSON::PP::a";
    }
    if (!exists $weapon_field_values->{$JSON::PP::b}) {
        die "Unknown field $JSON::PP::b";
    }

    return $weapon_field_values->{$JSON::PP::a} cmp $weapon_field_values->{$JSON::PP::b};
}

# filters the hash in place to remove obsolete fields
sub filter {
    my ($data, $filter_fields) = @_;
    if (ref $data eq "HASH") {
        for my $key (@$filter_fields) {
            delete $data->{$key};
        }
        for my $value (values %$data) {
            filter($value, $filter_fields);
        }
    } elsif (ref $data eq "ARRAY") {
        for my $value (@$data) {
            filter($value, $filter_fields);
        }
    }
}

my $json = JSON::PP->new;
# pretty print output
$json->pretty(1);
$json->indent_length(2);
$json->space_before(0);
# output fields in sorted order (minimizes diffs between runs)
$json->canonical(1);
# relaxed corectness checking of input
$json->relaxed(1);

for my $fname (glob("../Toolbox/*.json")){
    warn "Processing $fname\n";
    local $/;
    open IN, "<", $fname or die "Unable to open file $fname";
    my $json_text = <IN>;
    my $data = $json->decode($json_text);
    close IN;

    if ($fname =~ m/.*_units\.json$/) {
        # Main unit data
        filter($data, $unit_filter_fields);
        $json->sort_by(\&sort_unit);
    } elsif ($fname =~ m/add_new.*\.json$/) {
        # Add new unit profiles scripts
        filter($data, $unit_filter_fields);
        $json->sort_by(\&sort_unit);
    } elsif ($fname =~ m/cc_skills\.json$/) {
        # CC Skill data
        $json->sort_by(\&sort_cc);
    } elsif ($fname =~ m/hacking\.json$/) {
        # Hacking Skill data
        $json->sort_by(\&sort_hacking);
    } elsif ($fname =~ m/colors\.json$/) {
        # Army colors data
        $json->sort_by(\&sort_color);
    } elsif ($fname =~ m/merc_allowed\.json$/) {
        # Merc availability data
        $json->sort_by(\&sort_merc);
    } elsif ($fname =~ m/sectorials\.json$/) {
        # Sectorial army data
        filter($data, $sectorial_filter_fields);
        $json->sort_by(\&sort_sectorial);
    } elsif ($fname =~ m/specops\.json$/) {
        # Spec-ops data.  Does less validation than the others.
        $json->sort_by(\&sort_specops);
    } elsif ($fname =~ m/weapons\.json$/) {
        # Weapon data
        $json->sort_by(\&sort_weapon);
    } elsif ($fname =~ m/wiki_en\.json$/) {
        # Wiki index; is generated by a tool that emits clean JSON
        next;
    } else {
        die "Unknown JSON file $fname";
    }

    $json_text = $json->encode($data);
    open OUT, ">", $fname or die "Unable to open file $fname";
    print OUT $json_text;
    close OUT;
}
