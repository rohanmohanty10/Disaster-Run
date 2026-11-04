 

 

local function getHexColorSequence(p1) -- Line: 1
    local v2 = nil;

    if typeof(p1) == "table" then
        local v3 = #p1;

        if v3 > 1 then
            v2 = {};

            for i, v in ipairs(p1) do
                table.insert(v2, ColorSequenceKeypoint.new((i - 1) / (v3 - 1), Color3.fromHex(v)));
            end;
        elseif v3 == 1 then
            v2 = Color3.fromHex(p1[1]);
        end;
    elseif typeof(p1) == "string" then
        v2 = Color3.fromHex(p1);
    end;

    local v4 = v2 or Color3.new(1, 1, 1);

    return ColorSequence.new(v4);
end;

local function makeTitle(p5, p6, p7, p8) -- Line: 20
    local v9 = {
        tagText = p5,
        tagColor = p6
    };

    if p7 then
        v9.special = true;
    end;

    if p8 then
        v9 = p8(v9);
    end;

    return v9;
end;

local v10 = {
    monster = {
        tagText = "Monster",
        tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 0.85098, 0)), ColorSequenceKeypoint.new(0.5, Color3.new(1, 0.54902, 0)), ColorSequenceKeypoint.new(1, Color3.new(0.333333, 0.160784, 0.160784)) })
    },
    egoist = {
        tagText = "The Egoist",
        tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0.0666667, 1)), ColorSequenceKeypoint.new(0.5, Color3.new(0, 0.733333, 1)), ColorSequenceKeypoint.new(1, Color3.new(0, 0.384314, 1)) })
    },
    barou = {
        tagText = "King of the Field",
        tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 0, 0.0156863)), ColorSequenceKeypoint.new(1, Color3.new(0.462745, 0, 0.00784314)) })
    },
    kaiser = {
        tagText = "The Emperor\'s",
        tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0.431373, 1)), ColorSequenceKeypoint.new(0.5, Color3.new(1, 0.909804, 0.686275)), ColorSequenceKeypoint.new(1, Color3.new(1, 0.278431, 0.721569)) })
    },
    shidou = {
        tagText = "Zesty Demon",
        tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 0, 0.482353)), ColorSequenceKeypoint.new(1, Color3.new(1, 0.2, 0.654902)) })
    },
    chigiri = {
        tagText = "The Crimson Ojou-sama",
        tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 0, 0.0156863)), ColorSequenceKeypoint.new(1, Color3.new(1, 0.2, 0.654902)) })
    },
    sae = {
        tagText = "Japan\'s Treasure",
        tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 0, 0.34902)), ColorSequenceKeypoint.new(0.5, Color3.new(1, 0.556863, 0.882353)), ColorSequenceKeypoint.new(1, Color3.new(1, 0.2, 0.654902)) })
    },
    sae2 = {
        tagText = "The Prodigy",
        tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 0, 0.65098)), ColorSequenceKeypoint.new(0.5, Color3.new(0.647059, 0.0470588, 0.415686)), ColorSequenceKeypoint.new(1, Color3.new(1, 0, 0.65098)) })
    },
    sae3 = {
        tagText = "Underlashes Senior",
        tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.741176, 0.141176, 0.313725)), ColorSequenceKeypoint.new(0.5, Color3.new(1, 0.192157, 0.407843)), ColorSequenceKeypoint.new(1, Color3.new(0.741176, 0.141176, 0.313725)) })
    },
    don = {
        tagText = "The Zombie",
        tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.552941, 0.164706, 1)), ColorSequenceKeypoint.new(1, Color3.new(0.243137, 0.0901961, 0.47451)) })
    },
    lavinho = {
        tagText = "Danse Macabre",
        tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.992157, 1, 0.537255)), ColorSequenceKeypoint.new(1, Color3.new(1, 0.635294, 0)) })
    }
};
local v11, v12, v13 = getHexColorSequence({ "3e2e87", "e8393e" });
local v14 = {
    tagText = "The Butterfly",
    tagColor = v11
};

if v12 then
    v14.special = true;
end;

if v13 then
    v14 = v13(v14);
end;

v10.lavinho2 = v14;
local v15 = Color3.fromHex("fff5c5") or Color3.new(1, 1, 1);
local ColorSequence_new_ret, v16, v17 = ColorSequence.new(v15);
local v18 = {
    tagText = "The Free",
    tagColor = ColorSequence_new_ret
};

if v16 then
    v18.special = true;
end;

if v17 then
    v18 = v17(v18);
end;

v10.lavinho3 = v18;
v10.chris = {
    tagText = "World Star",
    tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.254902, 0.862745, 1)), ColorSequenceKeypoint.new(1, Color3.new(0, 0.235294, 1)) })
};
local v19, v20, v21 = getHexColorSequence({ "ffffad", "edca09" });
local v22 = {
    tagText = "Perfect Hero",
    tagColor = v19
};

if v20 then
    v22.special = true;
end;

if v21 then
    v22 = v21(v22);
end;

v10.chris2 = v22;
local v23, v24, v25 = getHexColorSequence({ "00021b", "0ac2e6", "ffffff" });
local v26 = {
    tagText = "Second Best Striker",
    tagColor = v23
};

if v24 then
    v26.special = true;
end;

if v25 then
    v26 = v25(v26);
end;

v10.chris3 = v26;
local v27 = Color3.fromHex("05a3be") or Color3.new(1, 1, 1);
local ColorSequence_new_ret2, v28, v29 = ColorSequence.new(v27);
local v30 = {
    tagText = "England\'s Crown Prince",
    tagColor = ColorSequence_new_ret2
};

if v28 then
    v30.special = true;
end;

if v29 then
    v30 = v29(v30);
end;

v10.chris4 = v30;
v10.noel = {
    tagText = "The Best Striker",
    tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.new(0.72549, 0.72549, 0.72549)) })
};
v10.rin = {
    tagText = "The Destroyer",
    tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.631373, 1, 0.968627)), ColorSequenceKeypoint.new(1, Color3.new(0.329412, 0.72549, 0.611765)) })
};
v10.otoya = {
    tagText = "Stealthy Ninja",
    tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 1, 0.0666667)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
};
v10.karasu = {
    tagText = "The Raven",
    tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.635294, 0.219608, 1)), ColorSequenceKeypoint.new(1, Color3.new(0.262745, 0.0784314, 0.380392)) })
};
v10.nagi = {
    tagText = "Sleeping Genius",
    tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.new(0.741176, 0.788235, 1)) })
};
v10.reo = {
    tagText = "The Chameleon",
    tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 0, 0.94902)), ColorSequenceKeypoint.new(1, Color3.new(0.4, 0, 1)) })
};
v10.leonardo = {
    tagText = "The Scion of Royale",
    tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 0.94902, 0.560784)), ColorSequenceKeypoint.new(1, Color3.new(0.266667, 1, 0)) })
};
v10.kunigami = {
    tagText = "The Fallen Hero",
    tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 0.533333, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 0.584314, 0)) })
};
v10.kunigami2 = {
    tagText = "Cyborg Hero",
    tagColor = ColorSequence.new(Color3.fromHex("cecece"), Color3.fromHex("ffbe00"))
};
v10.kunigami3 = {
    tagText = "Hero",
    tagColor = ColorSequence.new(Color3.fromHex("ffbe00"))
};
v10.kunigami4 = {
    tagText = "Wildcard",
    tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromHex("ffffff")), ColorSequenceKeypoint.new(0.5, Color3.fromHex("b10c0a")), ColorSequenceKeypoint.new(1, Color3.fromHex("000000")) })
};
v10.kunigami5 = {
    tagText = "Dark Horse",
    tagColor = ColorSequence.new(Color3.fromHex("ffbe00"), Color3.fromHex("000000"))
};
local v31 = {
    tagText = "Monk"
};
local v32 = Color3.fromHex("d38e5b") or Color3.new(1, 1, 1);
v31.tagColor = ColorSequence.new(v32);
v10.igurashi = v31;
local v33, v34, v35 = getHexColorSequence({ "432c4f", "e9b255" });
local v36 = {
    tagText = "Malicia Man",
    tagColor = v33
};

if v34 then
    v36.special = true;
end;

if v35 then
    v36 = v35(v36);
end;

v10.igurashi2 = v36;
v10.don2 = {
    tagText = "The Ace Eater",
    tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.635294, 0, 1)), ColorSequenceKeypoint.new(1, Color3.new(0.278431, 0, 0.615686)) })
};
v10.isagi2 = {
    tagText = "Demon King",
    tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.0901961, 0, 0.458824)), ColorSequenceKeypoint.new(1, Color3.new(1, 0, 0.0156863)) })
};
v10.kaiser2 = {
    tagText = "Blue Rose of Armageddon",
    tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0.333333, 1)), ColorSequenceKeypoint.new(1, Color3.new(0.988235, 0.054902, 0.380392)) })
};
v10.loki = {
    tagText = "The Speed Demon",
    tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 0.498039)), ColorSequenceKeypoint.new(1, Color3.new(0.333333, 0.333333, 1)) })
};
v10.kurona = {
    tagText = "Sharky",
    tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 0, 0.498039)), ColorSequenceKeypoint.new(1, Color3.new(0.372549, 0, 0.188235)) })
};
v10.yukimiya = {
    tagText = "Street Dribbler",
    tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 0.505882, 0.0117647)), ColorSequenceKeypoint.new(1, Color3.new(1, 0, 0.34902)) })
};
v10.kira = {
    tagText = "Japan\'s Hope",
    tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.new(0, 0.666667, 0.498039)) })
};
v10.kira2 = {
    tagText = "Yuta\'s Equal",
    tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.new(0, 0.666667, 0.498039)) })
};
v10.kiyora = {
    tagText = "Breakdancer",
    tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.203922, 0.917647, 0.894118)), ColorSequenceKeypoint.new(1, Color3.new(0.145098, 0.372549, 0.443137)) })
};
local v37, v38, v39 = getHexColorSequence({ "0b93ae", "9100bf" });
local v40 = {
    tagText = "Mr. Borderline",
    tagColor = v37
};

if v38 then
    v40.special = true;
end;

if v39 then
    v40 = v39(v40);
end;

v10.kiyora2 = v40;
v10.vip = {
    special = true,
    tagText = "VIP",
    tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 0.666667, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 0.956863, 0.341176)) })
};
local v41, v42, v43 = getHexColorSequence({ "4cec56", "6ffd99", "ed5c3d" });
local v44 = {
    tagText = "Crown Messenger",
    tagColor = v41
};

if v42 then
    v44.special = true;
end;

if v43 then
    v44 = v43(v44);
end;

v10.snuffy = v44;
local v45, v46, v47 = getHexColorSequence({ "f5ae46", "ffee84", "fdf1db" });
local v48 = {
    tagText = "The Phoenix",
    tagColor = v45
};

if v46 then
    v48.special = true;
end;

if v47 then
    v48 = v47(v48);
end;

v10.snuffy2 = v48;
local v49 = Color3.fromHex("f6fa34") or Color3.new(1, 1, 1);
local ColorSequence_new_ret3, v50, v51 = ColorSequence.new(v49);
local v52 = {
    tagText = "Victory Wayfarer",
    tagColor = ColorSequence_new_ret3
};

if v50 then
    v52.special = true;
end;

if v51 then
    v52 = v51(v52);
end;

v10.snuffy3 = v52;
local v53, v54, v55 = getHexColorSequence({ "2a8fa1", "032831", "a4fdfb" });
local v56 = {
    tagText = "Cheat Code Monster",
    tagColor = v53
};

if v54 then
    v56.special = true;
end;

if v55 then
    v56 = v55(v56);
end;

v10.rin2 = v56;
local v57, v58, v59 = getHexColorSequence({ "1bee8d", "005e2c", "022917" });
local v60 = {
    tagText = "The Beast",
    tagColor = v57
};

if v58 then
    v60.special = true;
end;

if v59 then
    v60 = v59(v60);
end;

v10.rin3 = v60;
local v61, v62, v63 = getHexColorSequence({ "19313d", "e80a5d" });
local v64 = {
    tagText = "Revenger",
    tagColor = v61
};

if v62 then
    v64.special = true;
end;

if v63 then
    v64 = v63(v64);
end;

v10.rin4 = v64;
local v65, v66, v67 = getHexColorSequence({ "032831", "a4fdfb", "032831" });
local v68 = {
    tagText = "Puppetmaster",
    tagColor = v65
};

if v66 then
    v68.special = true;
end;

if v67 then
    v68 = v67(v68);
end;

v10.rin5 = v68;
local v69, v70, v71 = getHexColorSequence({ "032831", "409997", "032831" });
local v72 = {
    tagText = "Benched",
    tagColor = v69
};

if v70 then
    v72.special = true;
end;

if v71 then
    v72 = v71(v72);
end;

v10.rin6 = v72;
local v73, v74, v75 = getHexColorSequence({ "f7ecb6", "f08f6f" });
local v76 = {
    tagText = "The Sovereign Sprinter",
    tagColor = v73
};

if v74 then
    v76.special = true;
end;

if v75 then
    v76 = v75(v76);
end;

v10.loki2 = v76;
local v77, v78, v79 = getHexColorSequence({ "f89537", "6262f5" });
local v80 = {
    tagText = "The Prodigy",
    tagColor = v77
};

if v78 then
    v80.special = true;
end;

if v79 then
    v80 = v79(v80);
end;

v10.loki3 = v80;
local v81, v82, v83 = getHexColorSequence({ "fcfd3f", "f8b020" });
local v84 = {
    tagText = "Cyborg",
    tagColor = v81
};

if v82 then
    v84.special = true;
end;

if v83 then
    v84 = v83(v84);
end;

v10.noel2 = v84;
local v85 = Color3.fromHex("b2f7ff") or Color3.new(1, 1, 1);
local ColorSequence_new_ret4, v86, v87 = ColorSequence.new(v85);
local v88 = {
    tagText = "Doctor",
    tagColor = ColorSequence_new_ret4
};

if v86 then
    v88.special = true;
end;

if v87 then
    v88 = v87(v88);
end;

v10.agi = v88;
local v89 = Color3.fromHex("c12b13") or Color3.new(1, 1, 1);
local ColorSequence_new_ret5, v90, v91 = ColorSequence.new(v89);
local v92 = {
    tagText = "Sinking Ship",
    tagColor = ColorSequence_new_ret5
};

if v90 then
    v92.special = true;
end;

if v91 then
    v92 = v91(v92);
end;

v10.yukimiya2 = v92;
local v93, v94, v95 = getHexColorSequence({ "f29e41", "ff6816" });
local v96 = {
    tagText = "The Envoy of Victory",
    tagColor = v93
};

if v94 then
    v96.special = true;
end;

if v95 then
    v96 = v95(v96);
end;

v10.yukimiya3 = v96;
local v97, v98, v99 = getHexColorSequence({ "32adce", "d08ad8", "61c25e" });
local v100 = {
    tagText = "1-on-1 Emperor",
    tagColor = v97
};

if v98 then
    v100.special = true;
end;

if v99 then
    v100 = v99(v100);
end;

v10.yukimiya4 = v100;
local v101, v102, v103 = getHexColorSequence({ "b4fcf9", "f4fefd" });
local v104 = {
    tagText = "The Genius of Adaptability",
    tagColor = v101
};

if v102 then
    v104.special = true;
end;

if v103 then
    v104 = v103(v104);
end;

v10.isagi3 = v104;
local v105, v106, v107 = getHexColorSequence({ "feff5f", "dddee0" });
local v108 = {
    tagText = "The Neo-Egoist",
    tagColor = v105
};

if v106 then
    v108.special = true;
end;

if v107 then
    v108 = v107(v108);
end;

v10.isagi4 = v108;
local v109, v110, v111 = getHexColorSequence({ "59eff0", "87a0b6" });
local v112 = {
    tagText = "Egoist Machine",
    tagColor = v109
};

if v110 then
    v112.special = true;
end;

if v111 then
    v112 = v111(v112);
end;

v10.isagi5 = v112;
local v113, v114, v115 = getHexColorSequence({ "838997", "1a1b1f" });
local v116 = {
    tagText = "Shadow King",
    tagColor = v113
};

if v114 then
    v116.special = true;
end;

if v115 then
    v116 = v115(v116);
end;

v10.isagi6 = v116;
local v117 = Color3.fromHex("38c1f8") or Color3.new(1, 1, 1);
local ColorSequence_new_ret6, v118, v119 = ColorSequence.new(v117);
local v120 = {
    tagText = "Shining Savior",
    tagColor = ColorSequence_new_ret6
};

if v118 then
    v120.special = true;
end;

if v119 then
    v120 = v119(v120);
end;

v10.isagi7 = v120;
local v121, v122, v123 = getHexColorSequence({ "192857", "314796", "4d6ac2" });
local v124 = {
    tagText = "Soccer Game\'s Ace",
    tagColor = v121
};

if v122 then
    v124.special = true;
end;

if v123 then
    v124 = v123(v124);
end;

v10.isagi8 = v124;
local v125, v126, v127 = getHexColorSequence({ "192857", "314796", "4d6ac2" });
local v128 = {
    tagText = "Heart of Soccer Game",
    tagColor = v125
};

if v126 then
    v128.special = true;
end;

if v127 then
    v128 = v127(v128);
end;

v10.isagi9 = v128;
local v129, v130, v131 = getHexColorSequence({ "fbff90", "010101" });
local v132 = {
    tagText = "Bumblebee",
    tagColor = v129
};

if v130 then
    v132.special = true;
end;

if v131 then
    v132 = v131(v132);
end;

v10.bachira = v132;
local v133, v134, v135 = getHexColorSequence({ "#ebdc3e", "#ebdc3e" });
local v136 = {
    tagText = "Original Egotist",
    tagColor = v133
};

if v134 then
    v136.special = true;
end;

if v135 then
    v136 = v135(v136);
end;

v10.bachira2 = v136;
local v137, v138, v139 = getHexColorSequence({ "#ebdc3e", "#de9f1e" });
local v140 = {
    tagText = "Hornet-San",
    tagColor = v137
};

if v138 then
    v140.special = true;
end;

if v139 then
    v140 = v139(v140);
end;

v10.bachira3 = v140;
local v141, v142, v143 = getHexColorSequence({ "e46113", "f5ed5e" });
local v144 = {
    tagText = "Fat Cat",
    tagColor = v141
};

if v142 then
    v144.special = true;
end;

if v143 then
    v144 = v143(v144);
end;

v10.buratsuta = v144;
local v145, v146, v147 = getHexColorSequence({ "e46113", "f5ed5e" });
local v148 = {
    tagText = "Greedy",
    tagColor = v145
};

if v146 then
    v148.special = true;
end;

if v147 then
    v148 = v147(v148);
end;

v10.buratsuta2 = v148;
local v149, v150, v151 = getHexColorSequence({ "2d4eb9", "29ff47" });
local v152 = {
    tagText = "Selfish Captain",
    tagColor = v149
};

if v150 then
    v152.special = true;
end;

if v151 then
    v152 = v151(v152);
end;

v10.aiku = v152;
local v153, v154, v155 = getHexColorSequence({ "752be2", "37f553" });
local v156 = {
    tagText = "The Final Wall",
    tagColor = v153
};

if v154 then
    v156.special = true;
end;

if v155 then
    v156 = v155(v156);
end;

v10.aiku2 = v156;
local v157 = Color3.fromHex("37f553") or Color3.new(1, 1, 1);
local ColorSequence_new_ret7, v158, v159 = ColorSequence.new(v157);
local v160 = {
    tagText = "Former Striker",
    tagColor = ColorSequence_new_ret7
};

if v158 then
    v160.special = true;
end;

if v159 then
    v160 = v159(v160);
end;

v10.aiku3 = v160;
local v161, v162, v163 = getHexColorSequence({ "00cbbb", "00fee4", "f6f7f1" });
local v164 = {
    tagText = "The Watchtower",
    tagColor = v161
};

if v162 then
    v164.special = true;
end;

if v163 then
    v164 = v163(v164);
end;

v10.niko = v164;
local v165 = Color3.fromHex("d5d9a5") or Color3.new(1, 1, 1);
local ColorSequence_new_ret8, v166, v167 = ColorSequence.new(v165);
local v168 = {
    tagText = "Stamina Freak",
    tagColor = ColorSequence_new_ret8
};

if v166 then
    v168.special = true;
end;

if v167 then
    v168 = v167(v168);
end;

v10.raichi = v168;
local v169, v170, v171 = getHexColorSequence({ "f9fab8", "fff753" });
local v172 = {
    tagText = "The Duel King",
    tagColor = v169
};

if v170 then
    v172.special = true;
end;

if v171 then
    v172 = v171(v172);
end;

v10.raichi2 = v172;
local v173 = Color3.fromHex("fff300") or Color3.new(1, 1, 1);
local ColorSequence_new_ret9, v174, v175 = ColorSequence.new(v173);
local v176 = {
    tagText = "God of Glam",
    tagColor = ColorSequence_new_ret9
};

if v174 then
    v176.special = true;
end;

if v175 then
    v176 = v175(v176);
end;

v10.aryu = v176;
local v177 = Color3.fromHex("ffca1c") or Color3.new(1, 1, 1);
local ColorSequence_new_ret10, v178, v179 = ColorSequence.new(v177);
local v180 = {
    tagText = "Glamorous",
    tagColor = ColorSequence_new_ret10
};

if v178 then
    v180.special = true;
end;

if v179 then
    v180 = v179(v180);
end;

v10.aryu2 = v180;
local v181, v182, v183 = getHexColorSequence({ "9cf1ff", "0a6b95", "041529" });
local v184 = {
    tagText = "Contrarian",
    tagColor = v181
};

if v182 then
    v184.special = true;
end;

if v183 then
    v184 = v183(v184);
end;

v10.charles = v184;
local v185, v186, v187 = getHexColorSequence({ "d421ff", "4a095a" });
local v188 = {
    tagText = "Imp",
    tagColor = v185
};

if v186 then
    v188.special = true;
end;

if v187 then
    v188 = v187(v188);
end;

v10.charles2 = v188;
local v189, v190, v191 = getHexColorSequence({ "e9cfb8", "ffeb74" });
local v192 = {
    tagText = "PXG\'s Heart",
    tagColor = v189
};

if v190 then
    v192.special = true;
end;

if v191 then
    v192 = v191(v192);
end;

v10.charles3 = v192;
local v193, v194, v195 = getHexColorSequence({ "4b76a8", "3a4e7c" });
local v196 = {
    tagText = "Superstar",
    tagColor = v193
};

if v194 then
    v196.special = true;
end;

if v195 then
    v196 = v195(v196);
end;

v10.kaiser5 = v196;
local v197, v198, v199 = getHexColorSequence({ "448ecd", "003e85" });
local v200 = {
    tagText = "Blue Rose",
    tagColor = v197
};

if v198 then
    v200.special = true;
end;

if v199 then
    v200 = v199(v200);
end;

v10.kaiser4 = v200;
local v201, v202, v203 = getHexColorSequence({ "fc5fff", "5ac3ff" });
local v204 = {
    tagText = "The Chosen Emperor",
    tagColor = v201
};

if v202 then
    v204.special = true;
end;

if v203 then
    v204 = v203(v204);
end;

v10.kaiser3 = v204;
local v205, v206, v207 = getHexColorSequence({ "ff1356", "ff0030" });
local v208 = {
    tagText = "The Red Panther",
    tagColor = v205
};

if v206 then
    v208.special = true;
end;

if v207 then
    v208 = v207(v208);
end;

v10.chigiri2 = v208;
local v209 = Color3.fromHex("ff0074") or Color3.new(1, 1, 1);
local ColorSequence_new_ret11, v210, v211 = ColorSequence.new(v209);
local v212 = {
    tagText = "Princess",
    tagColor = ColorSequence_new_ret11
};

if v210 then
    v212.special = true;
end;

if v211 then
    v212 = v211(v212);
end;

v10.chigiri3 = v212;
local v213, v214, v215 = getHexColorSequence({ "c832ad", "751c65" });
local v216 = {
    tagText = "Spellcaster",
    tagColor = v213
};

if v214 then
    v216.special = true;
end;

if v215 then
    v216 = v215(v216);
end;

v10.ness = v216;
local v217 = Color3.fromHex("ea8978") or Color3.new(1, 1, 1);
local ColorSequence_new_ret12, v218, v219 = ColorSequence.new(v217);
local v220 = {
    tagText = "Ace",
    tagColor = ColorSequence_new_ret12
};

if v218 then
    v220.special = true;
end;

if v219 then
    v220 = v219(v220);
end;

v10.sendou = v220;
local v221, v222, v223 = getHexColorSequence({ "ea8978", "fff1ee" });
local v224 = {
    tagText = "Hyena",
    tagColor = v221
};

if v222 then
    v224.special = true;
end;

if v223 then
    v224 = v223(v224);
end;

v10.sendou2 = v224;
local v225, v226, v227 = getHexColorSequence({ "05ac54", "ffffff" });
local v228 = {
    tagText = "Shining Hope",
    tagColor = v225
};

if v226 then
    v228.special = true;
end;

if v227 then
    v228 = v227(v228);
end;

v10.onaji = v228;
local v229, v230, v231 = getHexColorSequence({ "8ed4f6", "ffffff" });
local v232 = {
    tagText = "Ultra Sadist",
    tagColor = v229
};

if v230 then
    v232.special = true;
end;

if v231 then
    v232 = v231(v232);
end;

v10.hiori = v232;
local v233 = Color3.fromHex("8ed4f6") or Color3.new(1, 1, 1);
local ColorSequence_new_ret13, v234, v235 = ColorSequence.new(v233);
local v236 = {
    tagText = "Gamer",
    tagColor = ColorSequence_new_ret13
};

if v234 then
    v236.special = true;
end;

if v235 then
    v236 = v235(v236);
end;

v10.hiori2 = v236;
local v237, v238, v239 = getHexColorSequence({ "171d69", "403dff" });
local v240 = {
    tagText = "Assassin",
    tagColor = v237
};

if v238 then
    v240.special = true;
end;

if v239 then
    v240 = v239(v240);
end;

v10.karasu2 = v240;
local v241, v242, v243 = getHexColorSequence({ "352a40", "6e4378", "352a40" });
local v244 = {
    tagText = "Loud Crow",
    tagColor = v241
};

if v242 then
    v244.special = true;
end;

if v243 then
    v244 = v243(v244);
end;

v10.karasu3 = v244;
local v245, v246, v247 = getHexColorSequence({ "ff00ae", "000000" });
local v248 = {
    tagText = "Devil Boy",
    tagColor = v245
};

if v246 then
    v248.special = true;
end;

if v247 then
    v248 = v247(v248);
end;

v10.shidou2 = v248;
local v249 = Color3.fromHex("79001b") or Color3.new(1, 1, 1);
local ColorSequence_new_ret14, v250, v251 = ColorSequence.new(v249);
local v252 = {
    tagText = "King",
    tagColor = ColorSequence_new_ret14
};

if v250 then
    v252.special = true;
end;

if v251 then
    v252 = v251(v252);
end;

v10.barou2 = v252;
local v253, v254, v255 = getHexColorSequence({ "79001b", "000000" });
local v256 = {
    tagText = "Joker",
    tagColor = v253
};

if v254 then
    v256.special = true;
end;

if v255 then
    v256 = v255(v256);
end;

v10.barou3 = v256;
local v257 = Color3.fromHex("f81c22") or Color3.new(1, 1, 1);
local ColorSequence_new_ret15, v258, v259 = ColorSequence.new(v257);
local v260 = {
    tagText = "Tyrant",
    tagColor = ColorSequence_new_ret15
};

if v258 then
    v260.special = true;
end;

if v259 then
    v260 = v259(v260);
end;

v10.barou4 = v260;
local v261 = Color3.fromHex("bd2034") or Color3.new(1, 1, 1);
local ColorSequence_new_ret16, v262, v263 = ColorSequence.new(v261);
local v264 = {
    tagText = "The Puppeteer\'s Nightmare",
    tagColor = ColorSequence_new_ret16
};

if v262 then
    v264.special = true;
end;

if v263 then
    v264 = v263(v264);
end;

v10.barou5 = v264;
local v265 = Color3.fromHex("#1fd69d") or Color3.new(1, 1, 1);
local ColorSequence_new_ret17, v266, v267 = ColorSequence.new(v265);
local v268 = {
    tagText = "Neurotic Bullet Train",
    tagColor = ColorSequence_new_ret17
};

if v266 then
    v268.special = true;
end;

if v267 then
    v268 = v267(v268);
end;

v10.tokimitsu1 = v268;
local v269 = Color3.fromHex("bd2034") or Color3.new(1, 1, 1);
local ColorSequence_new_ret18, v270, v271 = ColorSequence.new(v269);
local v272 = {
    tagText = "N°1 Larper",
    tagColor = ColorSequence_new_ret18
};

if v270 then
    v272.special = true;
end;

if v271 then
    v272 = v271(v272);
end;

v10.hugo1 = v272;
local v273 = Color3.fromHex("bd2034") or Color3.new(1, 1, 1);
local ColorSequence_new_ret19, v274, v275 = ColorSequence.new(v273);
local v276 = {
    tagText = "Number 2 Philosophist",
    tagColor = ColorSequence_new_ret19
};

if v274 then
    v276.special = true;
end;

if v275 then
    v276 = v275(v276);
end;

v10.hugo2 = v276;
local v277, v278, v279 = getHexColorSequence({ "cc06f1", "ffffff" });
local v280 = {
    tagText = "Master of All Trades",
    tagColor = v277
};

if v278 then
    v280.special = true;
end;

if v279 then
    v280 = v279(v280);
end;

v10.reo2 = v280;
local v281, v282, v283 = getHexColorSequence({ "6832a8", "#511c85" });
local v284 = {
    tagText = "Copy-Cat",
    tagColor = v281
};

if v282 then
    v284.special = true;
end;

if v283 then
    v284 = v283(v284);
end;

v10.reo3 = v284;
local v285, v286, v287 = getHexColorSequence({ "6832a8", "#511c85" });
local v288 = {
    tagText = "Chamilleonaire",
    tagColor = v285
};

if v286 then
    v288.special = true;
end;

if v287 then
    v288 = v287(v288);
end;

v10.reo4 = v288;
local v289, v290, v291 = getHexColorSequence({ "000000", "ffffff" });
local v292 = {
    tagText = "Primordial Egoist",
    tagColor = v289
};

if v290 then
    v292.special = true;
end;

if v291 then
    v292 = v291(v292);
end;

v10.ego = v292;
local v293, v294, v295 = getHexColorSequence({ "000000", "6e7273", "ffffff" });
local v296 = {
    tagText = "Progenitor of Egoists",
    tagColor = v293
};

if v294 then
    v296.special = true;
end;

if v295 then
    v296 = v295(v296);
end;

v10.ego2 = v296;
local v297, v298, v299 = getHexColorSequence({ "44474e", "bac4c3" });
local v300 = {
    tagText = "Mastermind",
    tagColor = v297
};

if v298 then
    v300.special = true;
end;

if v299 then
    v300 = v299(v300);
end;

v10.ego3 = v300;
local v301 = Color3.fromHex("9e4e59") or Color3.new(1, 1, 1);
local ColorSequence_new_ret20, v302, v303 = ColorSequence.new(v301);
local v304 = {
    tagText = "Distant Dreamer",
    tagColor = ColorSequence_new_ret20
};

if v302 then
    v304.special = true;
end;

if v303 then
    v304 = v303(v304);
end;

v10.anri = v304;
local v305, v306, v307 = getHexColorSequence({ "f30b54", "b03f7f" });
local v308 = {
    tagText = "Reliable Planet",
    tagColor = v305
};

if v306 then
    v308.special = true;
end;

if v307 then
    v308 = v307(v308);
end;

v10.kurona2 = v308;
local v309, v310, v311 = getHexColorSequence({ "d4dad8", "383a39" });
local v312 = {
    tagText = "Feral Keeper",
    tagColor = v309
};

if v310 then
    v312.special = true;
end;

if v311 then
    v312 = v311(v312);
end;

v10.gagamaru = v312;
local v313, v314, v315 = getHexColorSequence({ "a3b7c5", "7ba6d3" });
local v316 = {
    tagText = "Japan\'s Guardian Deity",
    tagColor = v313
};

if v314 then
    v316.special = true;
end;

if v315 then
    v316 = v315(v316);
end;

v10.gagamaru2 = v316;
local v317, v318, v319 = getHexColorSequence({ "a2b3b4", "171f1f" });
local v320 = {
    tagText = "Bear Deflector",
    tagColor = v317
};

if v318 then
    v320.special = true;
end;

if v319 then
    v320 = v319(v320);
end;

v10.gagamaru3 = v320;
local v321, v322, v323 = getHexColorSequence({ "30384b", "295bb2" });
local v324 = {
    tagText = "Fortune Teller",
    tagColor = v321
};

if v322 then
    v324.special = true;
end;

if v323 then
    v324 = v323(v324);
end;

v10.reiji = v324;
local v325 = Color3.fromHex("c8716a") or Color3.new(1, 1, 1);
local ColorSequence_new_ret21, v326, v327 = ColorSequence.new(v325);
local v328 = {
    tagText = "Aomori\'s Messi",
    tagColor = ColorSequence_new_ret21
};

if v326 then
    v328.special = true;
end;

if v327 then
    v328 = v327(v328);
end;

v10.nishioka = v328;
local v329 = Color3.fromHex("00480c") or Color3.new(1, 1, 1);
local ColorSequence_new_ret22, v330, v331 = ColorSequence.new(v329);
local v332 = {
    tagText = "Heavy Tank",
    tagColor = ColorSequence_new_ret22
};

if v330 then
    v332.special = true;
end;

if v331 then
    v332 = v331(v332);
end;

v10.silva = v332;
local v333, v334, v335 = getHexColorSequence({ "dfcc80", "8c6e38" });
local v336 = {
    tagText = "Babyface",
    tagColor = v333
};

if v334 then
    v336.special = true;
end;

if v335 then
    v336 = v335(v336);
end;

v10.pablo = v336;
local v337, v338, v339 = getHexColorSequence({ "e6bcd6", "dee5c4", "73aebc" });
local v340 = {
    tagText = "Pastel Passer",
    tagColor = v337
};

if v338 then
    v340.special = true;
end;

if v339 then
    v340 = v339(v340);
end;

v10.pablo2 = v340;
local v341 = Color3.fromHex("9688fa") or Color3.new(1, 1, 1);
local ColorSequence_new_ret23, v342, v343 = ColorSequence.new(v341);
local v344 = {
    tagText = "Goal Junkie",
    tagColor = ColorSequence_new_ret23
};

if v342 then
    v344.special = true;
end;

if v343 then
    v344 = v343(v344);
end;

v10.adam = v344;
local v345, v346, v347 = getHexColorSequence({ "cbeeff", "1e3a62" });
local v348 = {
    tagText = "The Fallen Genius",
    tagColor = v345
};

if v346 then
    v348.special = true;
end;

if v347 then
    v348 = v347(v348);
end;

v10.nagi2 = v348;
local v349 = Color3.fromHex("fefefe") or Color3.new(1, 1, 1);
local ColorSequence_new_ret24, v350, v351 = ColorSequence.new(v349);
local v352 = {
    tagText = "Genius",
    tagColor = ColorSequence_new_ret24
};

if v350 then
    v352.special = true;
end;

if v351 then
    v352 = v351(v352);
end;

v10.nagi3 = v352;
local v353 = Color3.fromHex("c7a67d") or Color3.new(1, 1, 1);
local ColorSequence_new_ret25, v354, v355 = ColorSequence.new(v353);
local v356 = {
    tagText = "Average Joe",
    tagColor = ColorSequence_new_ret25
};

if v354 then
    v356.special = true;
end;

if v355 then
    v356 = v355(v356);
end;

v10.asahi = v356;
local v357 = Color3.fromHex("564c40") or Color3.new(1, 1, 1);
local ColorSequence_new_ret26, v358, v359 = ColorSequence.new(v357);
local v360 = {
    tagText = "Traitor",
    tagColor = ColorSequence_new_ret26
};

if v358 then
    v360.special = true;
end;

if v359 then
    v360 = v359(v360);
end;

v10.kuon = v360;
local v361 = Color3.fromHex("ccd8df") or Color3.new(1, 1, 1);
local ColorSequence_new_ret27, v362, v363 = ColorSequence.new(v361);
local v364 = {
    tagText = "Idiot",
    tagColor = ColorSequence_new_ret27
};

if v362 then
    v364.special = true;
end;

if v363 then
    v364 = v363(v364);
end;

v10.zantetsu = v364;
local v365 = Color3.fromHex("ccd8df") or Color3.new(1, 1, 1);
local ColorSequence_new_ret28, v366, v367 = ColorSequence.new(v365);
local v368 = {
    tagText = "Bullet Train",
    tagColor = ColorSequence_new_ret28
};

if v366 then
    v368.special = true;
end;

if v367 then
    v368 = v367(v368);
end;

v10.zantetsu2 = v368;
local v369 = Color3.fromHex("f25848") or Color3.new(1, 1, 1);
local ColorSequence_new_ret29, v370, v371 = ColorSequence.new(v369);
local v372 = {
    tagText = "Speedy Defender",
    tagColor = ColorSequence_new_ret29
};

if v370 then
    v372.special = true;
end;

if v371 then
    v372 = v371(v372);
end;

v10.neru = v372;
local v373 = Color3.fromHex("f25848") or Color3.new(1, 1, 1);
local ColorSequence_new_ret30, v374, v375 = ColorSequence.new(v373);
local v376 = {
    tagText = "Benchwarmer",
    tagColor = ColorSequence_new_ret30
};

if v374 then
    v376.special = true;
end;

if v375 then
    v376 = v375(v376);
end;

v10.neru2 = v376;
local v377 = Color3.fromHex("41394c") or Color3.new(1, 1, 1);
local ColorSequence_new_ret31, v378, v379 = ColorSequence.new(v377);
local v380 = {
    tagText = "Doberman",
    tagColor = ColorSequence_new_ret31
};

if v378 then
    v380.special = true;
end;

if v379 then
    v380 = v379(v380);
end;

v10.nio = v380;
v10.thankYou = {
    tagText = "Thankful",
    tagColor = getHexColorSequence({ "ff3300", "ff9500" }),
    special = true
};
v10.grateful = {
    tagText = "Grateful",
    tagColor = getHexColorSequence({ "ffee00", "ff4400" }),
    special = true
};
v10.gobbler = {
    tagText = "The Gobbler",
    tagColor = getHexColorSequence({ "ff6a00", "ffbb00" }),
    special = true
};
v10.hungry = {
    tagText = "Hungry",
    tagColor = getHexColorSequence({ "ff2f00", "ff8000" }),
    special = true
};
v10.thankfulforPhonk = {
    tagText = "Phonkful Thanker",
    tagColor = getHexColorSequence({ "ff3300", "ff9500" }),
    special = true
};
v10.christmastitle1 = {
    tagText = "Eggnog Brewer",
    tagColor = getHexColorSequence({ "ff0000", "ff0000" }),
    special = true
};
v10.christmastitle2 = {
    tagText = "Red-Nosed Reindeer",
    tagColor = getHexColorSequence({ "ff0000", "ffffff" }),
    special = true
};
v10.christmastitle3 = {
    tagText = "Christmas Stocker",
    tagColor = getHexColorSequence({ "ff0000", "ff0000" }),
    special = true
};
v10.christmastitle4 = {
    tagText = "Santa\'s Little Helper",
    tagColor = getHexColorSequence({ "ff0000", "ffffff" }),
    special = true
};
local v381 = {
    tagText = ", Blinded by Destiny",
    tagColor = getHexColorSequence({ "FE5A2F", "FCA741", "FE5A2F" }),
    special = true
};

if function(p382) -- Line: 235
    p382.nameaddition = true;
    p382.specialer = true;

    return p382;
end then
    v381.nameaddition = true;
    v381.specialer = true;
end;

v10.yukititles = v381;
local v383 = {
    tagText = ", Japan\'s Final Wall",
    tagColor = getHexColorSequence({ "C2D616", "D12D26", "C2D616" }),
    special = true
};

if function(p384) -- Line: 241
    p384.nameaddition = true;
    p384.specialer = true;

    return p384;
end then
    v383.nameaddition = true;
    v383.specialer = true;
end;

v10.aikuwallpaid = v383;
local v385 = {
    tagText = ", Thorned Superstar",
    tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0.333333, 1)), ColorSequenceKeypoint.new(1, Color3.new(0.988235, 0.054902, 0.380392)) }),
    special = true
};

if function(p386) -- Line: 250
    p386.nameaddition = true;
    p386.specialer = true;

    return p386;
end then
    v385.nameaddition = true;
    v385.specialer = true;
end;

v10.kaisermasterypaid = v385;
v10.nelisagimasterypaid = {
    tagText = "Shadow Striker",
    tagColor = getHexColorSequence({ "000000", "6E6E6E", "000000" }),
    special = true
};
local v387 = {
    tagText = ", New Generation World XI: Forward",
    tagColor = getHexColorSequence({ "00A6FF", "0D00FF", "00A6FF" }),
    special = true
};

if function(p388) -- Line: 260
    p388.nameaddition = true;
    p388.specialer = true;

    return p388;
end then
    v387.nameaddition = true;
    v387.specialer = true;
end;

v10.masterykaiser = v387;
local v389 = {
    tagText = " Of The Diamond Generation",
    tagColor = getHexColorSequence({ "C2D616", "D12D26", "C2D616" }),
    special = true
};

if function(p390) -- Line: 266
    p390.nameaddition = true;
    p390.specialer = true;

    return p390;
end then
    v389.nameaddition = true;
    v389.specialer = true;
end;

v10.masteryaiku = v389;
local v391 = {
    tagText = ", Reborn Anew",
    tagColor = getHexColorSequence({ "2B97FC", "5ED1FF", "2B97FC" }),
    special = true
};

if function(p392) -- Line: 272
    p392.nameaddition = true;
    p392.specialer = true;

    return p392;
end then
    v391.nameaddition = true;
    v391.specialer = true;
end;

v10.masterynelisagi = v391;

return v10;