 

local v1 = {}
local u2 = game:GetService("RunService"):IsServer()
local v3 = game:GetService("RunService")
local v4 = {
    ["percentStamina"] = 0.01,
    ["baseStamina"] = 1
}
local u5 = {}
local v6 = {}
local v7 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 10,
    ["statreq"] = {
        ["FightingStyleMastery"] = 1,
        ["/SKILL/BlackLeg"] = 1
    },
    ["cd"] = 3,
    ["desc"] = "User lands on his hands underneath an opponent\'s chin, then uses both hands to spring upwards to deliver a blow to the opponent\'s chin with both feet"
}
v6["B-Shot"] = v7
local v8 = {
    ["moneyreq"] = 500,
    ["stamreq"] = 15,
    ["statreq"] = {
        ["FightingStyleMastery"] = 10,
        ["/SKILL/BlackLeg"] = 2
    },
    ["cd"] = 17,
    ["desc"] = "A kick to the neck which user does whilst still on the ground"
}
v6.Coiller = v8
local v9 = {
    ["percentStamina"] = v4.percentStamina,
    ["baseStamina"] = v4.baseStamina,
    ["moneyreq"] = 750,
    ["statreq"] = {
        ["FightingStyleMastery"] = 20,
        ["/SKILL/BlackLeg"] = 3
    },
    ["stamreq"] = 0,
    ["cd"] = 0.2,
    ["desc"] = "Allows the users to actually jump off the air itself, allowing them to stay in the air for much longer than usual"
}
v6["Sky Walk"] = v9
local v10 = {
    ["moneyreq"] = 1250,
    ["stamreq"] = 25,
    ["statreq"] = {
        ["FightingStyleMastery"] = 25,
        ["/SKILL/BlackLeg"] = 4
    },
    ["cd"] = 8,
    ["desc"] = "User accelerates through the air while rotating at incredible speeds to generate a crushing blow upon impact."
}
v6.Concasser = v10
local v11 = {
    ["moneyreq"] = 1800,
    ["stamreq"] = 15,
    ["statreq"] = {
        ["FightingStyleMastery"] = 30,
        ["/SKILL/BlackLeg"] = 5
    },
    ["cd"] = 5,
    ["desc"] = "The user flips upside down and rotate their legs at high speeds to generate a small vortex capable of dealing spontaneous damage."
}
v6["Party Table Kick Course"] = v11
local v12 = {
    ["ULT"] = true,
    ["moneyreq"] = 3000,
    ["stamreq"] = 45,
    ["statreq"] = {
        ["FightingStyleMastery"] = 55,
        ["/SKILL/BlackLeg"] = 6
    },
    ["cd"] = 25,
    ["desc"] = "User delivers a swift strike from below that stuns and launches enemies skyward. Despite its simplicity, this technique packs enough force to be the most powerful basic black leg skill."
}
v6["Anti-Manner Kick Course"] = v12
local v13 = {
    ["transformation"] = true,
    ["stamreq"] = 0,
    ["statreq"] = {
        ["FightingStyleMastery"] = 125,
        ["/SKILL/BlackLeg"] = 7
    },
    ["cd"] = 1,
    ["desc"] = "User enshrouds their feet in violent flames whose intensity will scorch even the toughest of foes. This technique also augments the abilities of other black leg skills."
}
v6["Demon Step Transformation"] = v13
local v14 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 65,
    ["statreq"] = {
        ["FightingStyleMastery"] = 75,
        ["/SKILL/BlackLeg"] = 8
    },
    ["cd"] = 13,
    ["desc"] = "A series of instantaneous kicks performed solely with the user\'s flaming right leg to reach high temperatures whose intensity generate bands of colors."
}
v6["Demon Spectrum"] = v14
local v15 = {
    ["moneyreq"] = 3000,
    ["stamreq"] = 40,
    ["statreq"] = {
        ["FightingStyleMastery"] = 85,
        ["/SKILL/BlackLeg"] = 9
    },
    ["cd"] = 9,
    ["desc"] = "Teleport and strike an enemy from behind."
}
v6["Demon Flash"] = v15
local v16 = {
    ["moneyreq"] = 5000,
    ["stamreq"] = 45,
    ["statreq"] = {
        ["FightingStyleMastery"] = 90,
        ["/SKILL/BlackLeg"] = 10
    },
    ["cd"] = 15,
    ["desc"] = "Project fiery missiles with the demon leg."
}
v6["Demon Blitz"] = v16
local v17 = {
    ["moneyreq"] = 8000,
    ["stamreq"] = 75,
    ["statreq"] = {
        ["FightingStyleMastery"] = 130,
        ["/SKILL/BlackLeg"] = 11
    },
    ["cd"] = 20,
    ["desc"] = "Shower a set area with torrents of kicks before performing a drop-kick."
}
v6["Demon Axe Drop"] = v17
local v18 = {
    ["ULT"] = true,
    ["moneyreq"] = 12000,
    ["stamreq"] = 100,
    ["statreq"] = {
        ["FightingStyleMastery"] = 150,
        ["/SKILL/BlackLeg"] = 12
    },
    ["cd"] = 70,
    ["desc"] = "Perform a teleporting side-snap kick that sends the target flying amidst a blazing vortex."
}
v6["Demonic Sky Driller"] = v18
local v19 = {}
local v20 = {
    ["moneyreq"] = 0,
    ["statreq"] = {
        ["FightingStyleMastery"] = 1,
        ["/SKILL/Rokushiki"] = 1
    },
    ["stamreq"] = 15,
    ["cd"] = 10,
    ["desc"] = "The Shigan is a close-quarter combat technique, in which the user pushes their finger into a certain target at a very high speed"
}
v19.Shigan = v20
local v21 = {
    ["hyperArmor"] = true,
    ["moneyreq"] = 1250,
    ["statreq"] = {
        ["FightingStyleMastery"] = 5,
        ["/SKILL/Rokushiki"] = 2
    },
    ["stamreq"] = 15,
    ["cd"] = 1,
    ["desc"] = "The Soru allows the users to move at extremely high speeds in order to avoid attacks"
}
v19.Soru = v21
local v22 = {
    ["moneyreq"] = 1500,
    ["statreq"] = {
        ["FightingStyleMastery"] = 15,
        ["/SKILL/Rokushiki"] = 3
    },
    ["stamreq"] = 20,
    ["cd"] = 15,
    ["desc"] = "The Tekkai hardens the users\' muscles to the level of iron, in order to nullify damage taken from attacks."
}
v19.Tekkai = v22
local v23 = {
    ["percentStamina"] = v4.percentStamina,
    ["baseStamina"] = v4.baseStamina,
    ["moneyreq"] = 1750,
    ["statreq"] = {
        ["FightingStyleMastery"] = 20,
        ["/SKILL/Rokushiki"] = 4
    },
    ["stamreq"] = 0,
    ["cd"] = 0.2,
    ["desc"] = "The Geppo allows the users to actually jump off the air itself, allowing them to stay in the air for much longer than usual"
}
v19.Geppo = v23
local v24 = {
    ["moneyreq"] = 2000,
    ["statreq"] = {
        ["FightingStyleMastery"] = 25,
        ["/SKILL/Rokushiki"] = 5
    },
    ["stamreq"] = 20,
    ["cd"] = 5,
    ["desc"] = "The Rankyaku is a  powerful projectile technique, in which the users start by kicking at very high speeds and strength, sending out a sharp compressed air blade that can slice objects and greatly damage a human body"
}
v19.Rankakyu = v24
local v25 = {
    ["ULT"] = true,
    ["moneyreq"] = 9000,
    ["statreq"] = {
        ["FightingStyleMastery"] = 95,
        ["/SKILL/Rokushiki"] = 6
    },
    ["stamreq"] = 100,
    ["cd"] = 60,
    ["desc"] = "The user places both their fists right in front of the target to focus their physical strength to launch a devastating shock wave in a forward direction"
}
v19.Rokuogan = v25
local v26 = {}
local v27 = {
    ["stamreq"] = 0,
    ["statreq"] = {
        ["BusoMastery"] = 1
    },
    ["cd"] = 0.2,
    ["desc"] = "A form of Haki that allows the user to use their spirit to create, in essence, an invisible armor around themselves"
}
v26["Armament Haki"] = v27
local v28 = {
    ["Block"] = {
        ["stamreq"] = 10,
        ["cd"] = 0.2,
        ["desc"] = "Blocks against damage, will stun the user if attacks are too powerful"
    }
}
local v29 = {
    ["Heavy Punch"] = {
        ["stamreq"] = 0,
        ["cd"] = 3,
        ["desc"] = "A heavy punch that breaks blocks."
    }
}
local v30 = {}
local v31 = {
    ["stamreq"] = 20,
    ["statreq"] = {
        ["DevilFruitMastery"] = 15
    },
    ["cd"] = 0.25,
    ["desc"] = "A very straightforward punch intensified by stretching the user\'s highly elastic arm. Useful at mid range."
}
v30["Gomu-Gomu no Pistol"] = v31
local v32 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["DevilFruitMastery"] = 25
    },
    ["cd"] = 18,
    ["desc"] = "A technique that inflates the user from within the abdomen, temporarily enhancing defense and deflects cannonballs."
}
v30["Gomu-Gomu no Balloon"] = v32
local v33 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["DevilFruitMastery"] = 35
    },
    ["cd"] = 13,
    ["desc"] = "User stretches both arms and grabs onto the target before retracting and flinging themselves airborne."
}
v30["Gomu-Gomu no Rocket"] = v33
local v34 = {
    ["stamreq"] = 50,
    ["statreq"] = {
        ["DevilFruitMastery"] = 50
    },
    ["cd"] = 15,
    ["desc"] = "A stretched, two handed palm strike focused on pushing the enemy back and dealing medium damage."
}
v30["Gomu-Gomu no Bazooka"] = v34
local v35 = {
    ["stamreq"] = 20,
    ["statreq"] = {
        ["DevilFruitMastery"] = 60
    },
    ["cd"] = 20,
    ["desc"] = "This technique assaults your enemies with a swift barrage of stretched punches, pummeling them with overwhelming force."
}
v30["Gomu-Gomu no Gatling"] = v35
local v36 = {
    ["ULT"] = true,
    ["statreq"] = {
        ["DevilFruitMastery"] = 85
    },
    ["stamreq"] = 100,
    ["cd"] = 65,
    ["desc"] = "As an amplified version of its predecessor, this technique strikes faster than the eye can see."
}
v30["Gomu-Gomu no Rifle"] = v36
local v37 = {}
local v38 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 20,
    ["statreq"] = {
        ["SwordMastery"] = 0,
        ["/SKILL/1SS"] = 1
    },
    ["isFS"] = true,
    ["cd"] = 4,
    ["desc"] = "User creates a sharp, spiraling wind torrent that pierces and knocks back the target."
}
v37["36 Caliber Phoenix"] = v38
local v39 = {
    ["moneyreq"] = 750,
    ["stamreq"] = 25,
    ["statreq"] = {
        ["SwordMastery"] = 15,
        ["/SKILL/1SS"] = 2
    },
    ["isFS"] = true,
    ["cd"] = 10,
    ["desc"] = "User sheathes and concentrates for an instant before performing an innumerable amount of slashes in quick succession."
}
v37["Rapid Slashes"] = v39
local v40 = {
    ["moneyreq"] = 1999,
    ["stamreq"] = 40,
    ["statreq"] = {
        ["SwordMastery"] = 45,
        ["/SKILL/1SS"] = 3
    },
    ["isFS"] = true,
    ["cd"] = 10,
    ["desc"] = "User expands their consciousness and rends any hostiles within their field of fire upon release."
}
v37["Raging Serpent"] = v40
local v41 = {
    ["moneyreq"] = 9876,
    ["stamreq"] = 85,
    ["statreq"] = {
        ["SwordMastery"] = 80,
        ["/SKILL/1SS"] = 4
    },
    ["isFS"] = true,
    ["cd"] = 10,
    ["desc"] = "User sheathes and braces before dashing flashing towards the cursor with a hypersonic quick draw."
}
v37["Shishi Sonson"] = v41
local v42 = {
    ["ULT"] = true,
    ["moneyreq"] = 12345,
    ["stamreq"] = 100,
    ["statreq"] = {
        ["SwordMastery"] = 200,
        ["/SKILL/1SS"] = 5
    },
    ["isFS"] = true,
    ["cd"] = 60,
    ["desc"] = "While covered in dragon-like flames, the user drifts towards a targeted direction and ignites their trail after a brief pause."
}
v37["Dragon Blaze"] = v42
local v43 = {}
local v44 = {
    ["stamreq"] = 10,
    ["isFS"] = true,
    ["statreq"] = {
        ["Strength"] = 10
    },
    ["cd"] = 15,
    ["desc"] = "A heavy punch to the gut with increased knockback and damage."
}
v43["Gut Punch"] = v44
local v45 = {
    ["stamreq"] = 25,
    ["isFS"] = true,
    ["statreq"] = {
        ["Strength"] = 25
    },
    ["cd"] = 20,
    ["desc"] = "A heavy punch to the gut with increased knockback and damage."
}
v43["Ground Smash"] = v45
local v46 = {}
local v47 = {
    ["moneyreq"] = 0,
    ["statreq"] = {
        ["FightingStyleMastery"] = 0,
        ["/SKILL/Electro"] = 1
    },
    ["stamreq"] = 20,
    ["cd"] = 45,
    ["desc"] = "A veil of lightning coats the user\'s fists; subsequent attacks gain electric properties.",
    ["hyperArmor"] = true
}
v46["Electro Fist"] = v47
local v48 = {
    ["moneyreq"] = 750,
    ["statreq"] = {
        ["FightingStyleMastery"] = 15,
        ["/SKILL/Electro"] = 2
    },
    ["stamreq"] = 20,
    ["cd"] = 15,
    ["desc"] = "User generates an electrifying aura before propelling themselves forwards. "
}
v46["Electro Dash"] = v48
local v49 = {
    ["moneyreq"] = 1250,
    ["statreq"] = {
        ["FightingStyleMastery"] = 25,
        ["/SKILL/Electro"] = 3
    },
    ["stamreq"] = 30,
    ["cd"] = 5,
    ["desc"] = "User discharges several electrical currents forward."
}
v46["Electro Luna"] = v49
local v50 = {
    ["moneyreq"] = 3000,
    ["statreq"] = {
        ["FightingStyleMastery"] = 40,
        ["/SKILL/Electro"] = 4
    },
    ["stamreq"] = 45,
    ["cd"] = 9,
    ["desc"] = "User leaps into the air and proceeds to smite a designated area with thunderbolts."
}
v46["Electro Rain"] = v50
local v51 = {
    ["ULT"] = true,
    ["moneyreq"] = 9999,
    ["statreq"] = {
        ["FightingStyleMastery"] = 95,
        ["/SKILL/Electro"] = 5
    },
    ["stamreq"] = 75,
    ["cd"] = 45,
    ["desc"] = "User propels themselves upwards, emulating a lightning strike as they descend."
}
v46["Raiju Punishment"] = v51
local v52 = {}
local v53 = {
    ["stamreq"] = 0,
    ["statreq"] = {
        ["Strength"] = 0
    },
    ["cd"] = 0,
    ["desc"] = "A veil of lightning coats the user\'s fists; subsequent attacks gain electric properties."
}
v52["Yoru Slash"] = v53
local v54 = {
    ["stamreq"] = 0,
    ["statreq"] = {
        ["Strength"] = 0
    },
    ["cd"] = 0,
    ["desc"] = "User generates an electrifying aura before propelling themselves forwards. "
}
v52["Thousand Slashes"] = v54
local v55 = {}
local v56 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["DevilFruitMastery"] = 0
    },
    ["cd"] = 15,
    ["desc"] = "User propels several green fireballs that track their target.",
    ["InstantCast"] = true
}
v55.Firefly = v56
local v57 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["DevilFruitMastery"] = 10
    },
    ["cd"] = 8,
    ["desc"] = "Fly by borrowing properties of fire.",
    ["IsFlight"] = true
}
v55["Flame Flight"] = v57
local v58 = {
    ["stamreq"] = 50,
    ["statreq"] = {
        ["DevilFruitMastery"] = 35
    },
    ["cd"] = 6,
    ["desc"] = "A fiery projection of the user\'s fist. Ignites affected terrain."
}
v55.Hiken = v58
local v59 = {
    ["stamreq"] = 75,
    ["statreq"] = {
        ["DevilFruitMastery"] = 45
    },
    ["cd"] = 15,
    ["desc"] = "The user erupts into flames, creating a spiraling column of fire within a small vicinity."
}
v55["Flame Pillar"] = v59
local v60 = {
    ["ULT"] = true,
    ["stamreq"] = 125,
    ["statreq"] = {
        ["DevilFruitMastery"] = 95
    },
    ["cd"] = 65,
    ["desc"] = "The user launches a gigantic sphere of fire that implodes on impact, releasing waves of heat."
}
v55["Dai Enkai: Entei"] = v60
local v61 = {}
local v62 = {
    ["stamreq"] = 15,
    ["statreq"] = {
        ["DevilFruitMastery"] = 0
    },
    ["cd"] = 9,
    ["desc"] = "User summons a barrier and propells it foward, damaging targets."
}
v61["Barrier Crash"] = v62
local v63 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["DevilFruitMastery"] = 10
    },
    ["cd"] = 12,
    ["desc"] = "User erects a spherical barrier that isolates/protects a designated area. This is the ultimate defense agaisnt AOE skills.",
    ["InstantCast"] = true
}
v61["Barrier Sphere"] = v63
local v67 = {
    ["stamreq"] = 25,
    ["customCDInfo"] = {
        ["FullCooldown"] = 15,
        ["FunctionCheck"] = function(p64, p65) --[[ Name: FunctionCheck, Line 103 ]]
            --[[
            Upvalues:
                [1] = u2
            --]]
            local v66 = p65:GetAttribute("BariStairsCount")
            if p65:FindFirstChild("inCombat") == nil then
                return true
            elseif v66 then
                if v66 >= 3 then
                    if p64 and u2 == true then
                        return false
                    else
                        return false
                    end
                else
                    return
                end
            else
                return true
            end
        end
    },
    ["statreq"] = {
        ["DevilFruitMastery"] = 15
    },
    ["cd"] = 0.1,
    ["desc"] = "Indestructible stairs to help you traverse any terrain."
}
v61["Barrier Stairs"] = v67
local v68 = {
    ["stamreq"] = 30,
    ["statreq"] = {
        ["DevilFruitMastery"] = 35
    },
    ["cd"] = 15,
    ["desc"] = "User constructs and levitates a vessel before crashing it into the ground, trapping foes in the process.",
    ["InstantCast"] = true
}
v61["Barrier Cage"] = v68
local v69 = {
    ["ULT"] = true,
    ["stamreq"] = 55,
    ["statreq"] = {
        ["DevilFruitMastery"] = 55
    },
    ["cd"] = 45,
    ["desc"] = "User conjures several cone-shaped barriers to erupt from the ground."
}
v61["Barrier Spikes"] = v69
local v70 = {}
local v71 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["DevilFruitMastery"] = 20
    },
    ["cd"] = 12,
    ["desc"] = "A sword thrust at the speed of light!"
}
v70["Light Lunge"] = v71
local v72 = {
    ["stamreq"] = 65,
    ["statreq"] = {
        ["DevilFruitMastery"] = 40
    },
    ["cd"] = 13,
    ["desc"] = "Discharge a burst of light that explodes on impact."
}
v70["Light Kick"] = v72
local v73 = {
    ["stamreq"] = 75,
    ["statreq"] = {
        ["DevilFruitMastery"] = 55
    },
    ["cd"] = 14,
    ["desc"] = "User directs a maneuverable ray of light to scorch everything in its path."
}
v70["Light Ray"] = v73
local v74 = {
    ["stamreq"] = 95,
    ["statreq"] = {
        ["DevilFruitMastery"] = 75
    },
    ["cd"] = 10,
    ["desc"] = "User zooms above a designated location before unleashing a light kick downwards.",
    ["InstantCast"] = true
}
v70["Mirror Kick"] = v74
local v75 = {
    ["ULT"] = true,
    ["stamreq"] = 50,
    ["statreq"] = {
        ["DevilFruitMastery"] = 95
    },
    ["cd"] = 45,
    ["desc"] = "A devestating barrage of explosive beams."
}
v70["Jewels of Light"] = v75
local v76 = {
    ["stamreq"] = 10,
    ["statreq"] = {
        ["DevilFruitMastery"] = 0
    },
    ["cd"] = 0.5,
    ["desc"] = "Passive: Dash replaced with teleport."
}
v70.PikaDash = v76
local v77 = {
    ["stamreq"] = 15,
    ["statreq"] = {
        ["DevilFruitMastery"] = 60
    },
    ["cd"] = 15,
    ["desc"] = "User transforms into light and flys, reflecting off surfaces when touched.",
    ["InstantCast"] = true,
    ["IsFlight"] = true
}
v70["Light Flight"] = v77
local v78 = {}
local v79 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["DevilFruitMastery"] = 0
    },
    ["cd"] = 5,
    ["desc"] = "User makes them self invisble and undetected"
}
v78["Self Invisibility"] = v79
local v80 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["DevilFruitMastery"] = 15
    },
    ["cd"] = 8,
    ["desc"] = "User makes everyone around them invisible and undetected."
}
v78["Area Invisibility"] = v80
local v81 = {
    ["stamreq"] = 30,
    ["statreq"] = {
        ["DevilFruitMastery"] = 35
    },
    ["cd"] = 3,
    ["desc"] = "User picks up a rock and makes it invisble then throws."
}
v78["Invisible Rock Throw"] = v81
local v82 = {}
local v83 = {
    ["stamreq"] = 15,
    ["statreq"] = {
        ["DevilFruitMastery"] = 0
    },
    ["cd"] = 5,
    ["desc"] = "Submerge yourself in lava for a while and emerge with a sudden punch."
}
v82["Magma Swamp"] = v83
local v84 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["DevilFruitMastery"] = 25
    },
    ["cd"] = 15,
    ["desc"] = "User calls forth bursts of magma from under all nearby enemies."
}
v82["Magma Eruption"] = v84
local v85 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["DevilFruitMastery"] = 45
    },
    ["cd"] = 7,
    ["desc"] = "Envelope one arm with magma and unleash a deadly strike."
}
v82["Magma Fist"] = v85
local v86 = {
    ["stamreq"] = 50,
    ["statreq"] = {
        ["DevilFruitMastery"] = 65
    },
    ["cd"] = 14,
    ["desc"] = "Fire a mass of hound-like magma with overwhelming might."
}
v82["Magma Hound"] = v86
local v87 = {
    ["ULT"] = true,
    ["stamreq"] = 25,
    ["statreq"] = {
        ["DevilFruitMastery"] = 95
    },
    ["cd"] = 50,
    ["desc"] = "Let loose a sky of red."
}
v82["Magma Rain"] = v87
local v88 = {}
local v89 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["SwordMastery"] = 50
    },
    ["cd"] = 20,
    ["desc"] = "User spins around dealing aoe damage"
}
v88["Kiribachi Frenzy"] = v89
local v90 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["SwordMastery"] = 65
    },
    ["cd"] = 12,
    ["desc"] = "User smashes the ground with kiribachi"
}
v88["Kiribachi Smash"] = v90
local v91 = {
    ["ULT"] = true,
    ["stamreq"] = 0,
    ["statreq"] = {
        ["DevilFruitMastery"] = 0
    },
    ["cd"] = 0,
    ["desc"] = "User constructs and levitates a vessel before crashing it into the ground, trapping foes in the process."
}
v88["Kiribachi Throw"] = v91
__set_list(u5, 1, {v6, v19, v26, v28, v29, v30, v37, v43, v46, v52, v55, v61, v70, v78, v82, v88})
local v92 = {}
local v93 = {
    ["stamreq"] = 30,
    ["statreq"] = {
        ["DevilFruitMastery"] = 0
    },
    ["cd"] = 0.75,
    ["desc"] = "Launch glacial spears that produce patches of frost."
}
v92["Ice Partisan"] = v93
local v94 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["DevilFruitMastery"] = 15
    },
    ["cd"] = 16,
    ["desc"] = "The fanciest method of transportation."
}
v92["Ice Bike"] = v94
local v95 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["DevilFruitMastery"] = 30
    },
    ["cd"] = 15,
    ["desc"] = "Propel a mass of pheasant-shaped ice capable of freezing victims."
}
v92["Pheasant Beak"] = v95
local v96 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["DevilFruitMastery"] = 55
    },
    ["cd"] = 14,
    ["desc"] = "Chunks of ice burst forth to cripple enemies."
}
v92["Ice Stomp"] = v96
local v97 = {
    ["stamreq"] = 60,
    ["statreq"] = {
        ["DevilFruitMastery"] = 70
    },
    ["cd"] = 12,
    ["desc"] = "Slash thrice with a frigid blade."
}
v92["Frost Blade"] = v97
local v98 = {
    ["ULT"] = true,
    ["stamreq"] = 75,
    ["statreq"] = {
        ["DevilFruitMastery"] = 85
    },
    ["cd"] = 50,
    ["desc"] = "Flash freeze everything within a vast radius."
}
v92["Ice Age"] = v98
local v99 = {}
local v100 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 25,
    ["statreq"] = {
        ["FightingStyleMastery"] = 0,
        ["/SKILL/FishmanKarate"] = 1
    },
    ["cd"] = 8,
    ["desc"] = "Deliver a crushing blow with drenched fists."
}
v99["Five Thousand Brick Fist"] = v100
local v101 = {
    ["moneyreq"] = 2000,
    ["stamreq"] = 35,
    ["statreq"] = {
        ["FightingStyleMastery"] = 25,
        ["/SKILL/FishmanKarate"] = 2
    },
    ["cd"] = 20,
    ["desc"] = "Entrap the target in a levitating sphere of water.",
    ["InstantCast"] = true
}
v99["Water Prison"] = v101
local v102 = {
    ["moneyreq"] = 4000,
    ["stamreq"] = 40,
    ["statreq"] = {
        ["FightingStyleMastery"] = 50,
        ["/SKILL/FishmanKarate"] = 3
    },
    ["cd"] = 15,
    ["desc"] = "Release a string of shark-shaped projectiles that rupture on impact"
}
v99["Shark Barrage"] = v102
local v103 = {
    ["moneyreq"] = 6000,
    ["stamreq"] = 50,
    ["statreq"] = {
        ["FightingStyleMastery"] = 75,
        ["/SKILL/FishmanKarate"] = 4
    },
    ["cd"] = 6,
    ["desc"] = "Sends forth a giant serpent made of water that follows your mouse and explodes on contact.",
    ["InstantCast"] = true
}
v99["Water Serpent"] = v103
local v104 = {
    ["ULT"] = true,
    ["moneyreq"] = 12000,
    ["stamreq"] = 150,
    ["statreq"] = {
        ["FightingStyleMastery"] = 125,
        ["/SKILL/FishmanKarate"] = 5
    },
    ["cd"] = 45,
    ["desc"] = "User generates a large water bomb and shoots it towards a target."
}
v99["Water Bomb"] = v104
local v105 = {}
local v106 = {
    ["stamreq"] = 10,
    ["statreq"] = {
        ["DevilFruitMastery"] = 0
    },
    ["cd"] = 0.75,
    ["desc"] = "User summons a barrier and propells it foward, damaging targets."
}
v105.BombDash = v106
local v107 = {
    ["stamreq"] = 15,
    ["percentStamina"] = 0.02,
    ["statreq"] = {
        ["DevilFruitMastery"] = 0
    },
    ["cd"] = 1,
    ["desc"] = "Propel yourself to bombastic heights."
}
v105["Explosive Leap"] = v107
local v108 = {
    ["stamreq"] = 30,
    ["statreq"] = {
        ["DevilFruitMastery"] = 15
    },
    ["cd"] = 3,
    ["desc"] = "A target location is combusted.",
    ["InstantCast"] = true
}
v105["Explosive Swipe"] = v108
local v109 = {
    ["stamreq"] = 50,
    ["statreq"] = {
        ["DevilFruitMastery"] = 30
    },
    ["cd"] = 9,
    ["desc"] = "Patches of terrain are transmuted into landmines."
}
v105["Explosive Mines"] = v109
local v110 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["DevilFruitMastery"] = 50
    },
    ["cd"] = 19,
    ["desc"] = "Deliver a point blank detonation in someone\'s face."
}
v105["Explosive Grab"] = v110
local v111 = {
    ["ULT"] = true,
    ["stamreq"] = 0,
    ["statreq"] = {
        ["DevilFruitMastery"] = 85
    },
    ["cd"] = 45,
    ["desc"] = "Sacrifice your very self for the ultimate art."
}
v105["Self Destruction"] = v111
local v112 = {}
local v113 = {
    ["stamreq"] = 15,
    ["statreq"] = {
        ["DevilFruitMastery"] = 0
    },
    ["cd"] = 0.5,
    ["desc"] = "User constructs and levitates a vessel before crashing it into the ground, trapping foes in the process."
}
v112.GoroDash = v113
local v114 = {
    ["stamreq"] = 15,
    ["statreq"] = {
        ["DevilFruitMastery"] = 0
    },
    ["cd"] = 15,
    ["desc"] = "Conjure several bolts of lightning in an adjustable area."
}
v112["Lightning Paralyzation"] = v114
local v115 = {
    ["hyperArmor"] = true,
    ["stamreq"] = 30,
    ["statreq"] = {
        ["DevilFruitMastery"] = 15
    },
    ["cd"] = 12,
    ["desc"] = "Flash toward a target location and discharge electricity. "
}
v112["Flash Smash"] = v115
local v116 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["DevilFruitMastery"] = 35
    },
    ["cd"] = 16,
    ["desc"] = "Flash thru the air, allowing for quick transportation.",
    ["IsFlight"] = true
}
v112["Lightning Form"] = v116
local v117 = {
    ["stamreq"] = 75,
    ["statreq"] = {
        ["DevilFruitMastery"] = 50
    },
    ["cd"] = 18,
    ["desc"] = "Call upon torrents of lightning bolts to smite a wide area. "
}
v112["Lightning Wrath"] = v117
local v118 = {
    ["stamreq"] = 50,
    ["statreq"] = {
        ["DevilFruitMastery"] = 75
    },
    ["cd"] = 7,
    ["desc"] = "Release a current of electricity shaped like a dragon and does chain damage."
}
v112["Lightning Dragon"] = v118
local v119 = {
    ["ULT"] = true,
    ["stamreq"] = 95,
    ["statreq"] = {
        ["DevilFruitMastery"] = 125
    },
    ["cd"] = 65,
    ["desc"] = "Several thunderstorms are condensed to unleash a sphere of thundery destruction."
}
v112["Thunder Greeting"] = v119
local v120 = {}
local v121 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["Strength"] = 25
    },
    ["cd"] = 10,
    ["desc"] = "A rapid thrust"
}
v120["Rapid Thrust"] = v121
local v122 = {
    ["stamreq"] = 40,
    ["statreq"] = {
        ["Strength"] = 45
    },
    ["cd"] = 15,
    ["desc"] = "User spins their pole over their head."
}
v120["Golden Sweep"] = v122
local v123 = {
    ["stamreq"] = 20,
    ["statreq"] = {
        ["Strength"] = 75
    },
    ["cd"] = 25,
    ["desc"] = "A counter move that heals damage taken",
    ["IsCounter"] = true
}
v120["Pole Counter"] = v123
local v124 = {
    ["stamreq"] = 0,
    ["statreq"] = {
        ["Strength"] = 0,
        ["DF"] = { "Goro-Goro", "Goru-Goru" }
    },
    ["cd"] = 2,
    ["desc"] = "User constructs and levitates a vessel before crashing it into the ground, trapping foes in the process."
}
v120["Golden Staff Transform"] = v124
local v125 = {}
local v126 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["Strength"] = 25
    },
    ["cd"] = 15,
    ["desc"] = "User rings their bell and heals party members including themselves."
}
v125["Healing Rhyme"] = v126
local v127 = {
    ["stamreq"] = 0,
    ["statreq"] = {
        ["SwordMastery"] = 0
    },
    ["cd"] = 0,
    ["desc"] = "User summons a barrier and propells it foward, damaging targets."
}
v125["Juggernaut Rhyme"] = v127
local v128 = {}
local v129 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["SwordMastery"] = 20
    },
    ["cd"] = 20,
    ["desc"] = "User bits on the candy cane and gets health regen"
}
v128["Sweet Treat"] = v129
local v130 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["SwordMastery"] = 50
    },
    ["cd"] = 15,
    ["desc"] = "User stabs the floor summoning ice that freezes."
}
v128["Flash Freeze"] = v130
local v131 = {}
local v132 = {
    ["stamreq"] = 30,
    ["statreq"] = {
        ["DevilFruitMastery"] = 15
    },
    ["cd"] = 5,
    ["desc"] = "Repel everything within a short area towards the cursor."
}
v131["Gravity Push"] = v132
local v133 = {
    ["stamreq"] = 10,
    ["statreq"] = {
        ["DevilFruitMastery"] = 35
    },
    ["cd"] = 10,
    ["desc"] = "A target is pulled towards the user.",
    ["IsFlight"] = true
}
v131["Gravity Fly"] = v133
local v134 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["DevilFruitMastery"] = 45
    },
    ["cd"] = 15,
    ["desc"] = "Fly by levitating a chunk of the terrain."
}
v131["Gravity Pull"] = v134
local v135 = {
    ["stamreq"] = 50,
    ["statreq"] = {
        ["DevilFruitMastery"] = 60
    },
    ["cd"] = 12,
    ["desc"] = "Assert pressure over an increasing area of effect."
}
v131["Gravity Dominance"] = v135
local v136 = {
    ["stamreq"] = 75,
    ["statreq"] = {
        ["DevilFruitMastery"] = 70
    },
    ["cd"] = 15,
    ["desc"] = "Redirect a meteor\'s trajectory towards the cursor."
}
v131["Meteor Strike"] = v136
local v137 = {
    ["ULT"] = true,
    ["stamreq"] = 130,
    ["statreq"] = {
        ["DevilFruitMastery"] = 85
    },
    ["cd"] = 45,
    ["desc"] = "Bring down a cluster of cosmic debris."
}
v131["Meteor Fury"] = v137
local v138 = {}
local v139 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["SwordMastery"] = 25
    },
    ["cd"] = 7,
    ["desc"] = "User grabs all targets near towards them with the power of gravity then preceeds to rapid slash them"
}
v138["Gravity Frenzy"] = v139
local v140 = {
    ["stamreq"] = 50,
    ["statreq"] = {
        ["SwordMastery"] = 50
    },
    ["cd"] = 15,
    ["desc"] = "User targets a specific area with the power of gravity"
}
v138["Gravity Field"] = v140
local v141 = {}
local v142 = {
    ["stamreq"] = 20,
    ["statreq"] = {
        ["SwordMastery"] = 25
    },
    ["cd"] = 15,
    ["desc"] = "User throws their trident and pulls targets towards them",
    ["Grounded"] = true
}
v141["Trident Pull"] = v142
local v143 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["SwordMastery"] = 50
    },
    ["cd"] = 17,
    ["desc"] = "User impales the target doing bleed damage then smashing them to the ground after"
}
v141["Trident Impale"] = v143
local v144 = {}
local v145 = {
    ["stamreq"] = 20,
    ["statreq"] = {
        ["DevilFruitMastery"] = 15
    },
    ["cd"] = 2,
    ["desc"] = "Shoot a small heart towards the target, if hit turning them to stone for a short time."
}
v144["Love Pistol"] = v145
local v146 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["DevilFruitMastery"] = 25
    },
    ["cd"] = 14,
    ["desc"] = "Charm those around you and stun them for a short time."
}
v144["Love Bomb"] = v146
local v147 = {
    ["stamreq"] = 40,
    ["statreq"] = {
        ["DevilFruitMastery"] = 40
    },
    ["cd"] = 13,
    ["desc"] = "Release multiple waves of love, turning all targets that it passes thru into stone."
}
v144["Love Wave"] = v147
local v148 = {
    ["stamreq"] = 50,
    ["statreq"] = {
        ["DevilFruitMastery"] = 60
    },
    ["cd"] = 15,
    ["desc"] = "Release a burst of arrows that block break and turns targets into stone."
}
v144["Love Burst"] = v148
local v149 = {
    ["ULT"] = true,
    ["stamreq"] = 35,
    ["statreq"] = {
        ["DevilFruitMastery"] = 90
    },
    ["cd"] = 45,
    ["desc"] = "A barrage of powerful kicks"
}
v144["Perfume Femur"] = v149
local v150 = {}
local v151 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["SwordMastery"] = 20
    },
    ["cd"] = 10,
    ["desc"] = "User smells the flower gaining stamina regen"
}
v150["Flower Smell"] = v151
local v152 = {
    ["stamreq"] = 40,
    ["statreq"] = {
        ["SwordMastery"] = 40
    },
    ["cd"] = 15,
    ["desc"] = "User waves their flower, charming those around and brings them closer"
}
v150["Flower Charm"] = v152
local v153 = {}
local v154 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["DevilFruitMastery"] = 20
    },
    ["cd"] = 9,
    ["desc"] = "Launch a space-shattering ball of shock-waves a short distance toward the cursor."
}
v153["Shock Punch"] = v154
local v155 = {
    ["stamreq"] = 40,
    ["statreq"] = {
        ["DevilFruitMastery"] = 45
    },
    ["cd"] = 15,
    ["desc"] = "Obliterate a target with three localized earthquakes delivered at point-blank range."
}
v153["Head Crusher"] = v155
local v156 = {
    ["stamreq"] = 50,
    ["statreq"] = {
        ["DevilFruitMastery"] = 65
    },
    ["cd"] = 20,
    ["desc"] = "Short-duration counter that prompts a teleporting Shock Punch.",
    ["IsCounter"] = true
}
v153["Come AT me"] = v156
local v157 = {
    ["stamreq"] = 80,
    ["statreq"] = {
        ["DevilFruitMastery"] = 80
    },
    ["cd"] = 45,
    ["desc"] = "Fracture space within a small proximity to crush surrounding foes."
}
v153["Blast Clutcher"] = v157
local v158 = {
    ["ULT"] = true,
    ["stamreq"] = 130,
    ["statreq"] = {
        ["DevilFruitMastery"] = 115
    },
    ["cd"] = 75,
    ["desc"] = "A two-stage attack of seismic and tidal waves. Enemies within a huge vicinity are squashed between colliding tsunamis."
}
v153["Sea Quake"] = v158
local v159 = {}
local v160 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["SwordMastery"] = 45
    },
    ["cd"] = 15,
    ["desc"] = "Rotate the mighty polearm at extremely high speeds to continuously damage foes.",
    ["InstantCast"] = true
}
v159["Heavy Sweep"] = v160
local v161 = {
    ["stamreq"] = 55,
    ["statreq"] = {
        ["SwordMastery"] = 75
    },
    ["cd"] = 25,
    ["desc"] = "Perform a devestating smash; the number of quake-slashes incurred depends on the user\'s fruit.",
    ["InstantCast"] = true
}
v159["Shockwave Slash"] = v161
local v162 = {}
local v163 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["Strength"] = 50
    },
    ["cd"] = 15,
    ["desc"] = "SMASH THAT HAMMER"
}
v162["Elo Smash"] = v163
local v164 = {
    ["stamreq"] = 50,
    ["statreq"] = {
        ["Strength"] = 69
    },
    ["cd"] = 25,
    ["desc"] = "SMASHES TARGET"
}
v162["Pounding Festival"] = v164
local v165 = {}
local v166 = {
    ["stamreq"] = 0,
    ["statreq"] = {
        ["SwordMastery"] = 0
    },
    ["cd"] = 0.2,
    ["desc"] = "Summons a bunny which will obey your commands"
}
v165["Summon Bunny"] = v166
local v167 = {
    ["stamreq"] = 0,
    ["statreq"] = {
        ["SwordMastery"] = 0
    },
    ["cd"] = 0,
    ["desc"] = "Give your bunnies a target to attack",
    ["InstantCast"] = true
}
v165["Bunny Target"] = v167
local v168 = {
    ["stamreq"] = 0,
    ["statreq"] = {
        ["SwordMastery"] = 0
    },
    ["cd"] = 0,
    ["desc"] = "Command your bunnies to move to a given location"
}
v165["Bunny Move"] = v168
local v169 = {
    ["stamreq"] = 0,
    ["statreq"] = {
        ["SwordMastery"] = 0
    },
    ["cd"] = 3,
    ["desc"] = "Recalls your current bunny and teleports them to you"
}
v165["Bunny Recall"] = v169
__set_list(u5, 17, {v92, v99, v105, v112, v120, v125, v128, v131, v138, v141, v144, v150, v153, v159, v162, v165})
local v170 = {}
local v171 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["DevilFruitMastery"] = 15
    },
    ["cd"] = 8,
    ["desc"] = "Achieve flight by rotating both arms like airplane propellers. "
}
v170["Spinning Flight"] = v171
local v172 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["DevilFruitMastery"] = 35
    },
    ["cd"] = 15,
    ["desc"] = "Obliterate a target with three localized earthquakes delivered at point-blank range."
}
v170["Spinning Cyclone"] = v172
local v173 = {
    ["stamreq"] = 40,
    ["statreq"] = {
        ["DevilFruitMastery"] = 50
    },
    ["cd"] = 10,
    ["desc"] = "Short-duration counter that prompts a teleporting Shock Punch."
}
v170["Twister Throw"] = v173
local v174 = {}
local v175 = {
    ["stamreq"] = 0,
    ["statreq"] = {
        ["DevilFruitMastery"] = 15
    },
    ["cd"] = 0.1,
    ["desc"] = "Elevate and enter a state of levitation."
}
v174["Kilo Rise"] = v175
local v176 = {
    ["stamreq"] = 0,
    ["statreq"] = {
        ["DevilFruitMastery"] = 15
    },
    ["cd"] = 0.1,
    ["desc"] = "Enter a state of levitation and descend at a controlled pace."
}
v174["Kilo Descend"] = v176
local v177 = {
    ["stamreq"] = 65,
    ["statreq"] = {
        ["DevilFruitMastery"] = 45
    },
    ["cd"] = 50,
    ["desc"] = "User increases their own weight and enters a state of freefall. Impact radius scales with initial height."
}
v174["Kilo Crash"] = v177
local v178 = {
    ["stamreq"] = 0,
    ["statreq"] = {
        ["DevilFruitMastery"] = 0
    },
    ["cd"] = 0,
    ["desc"] = "User makes their body heavy and crashes down."
}
v174["Kilo Float"] = v178
local v179 = {}
local v180 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 35,
    ["statreq"] = {
        ["SwordMastery"] = 35,
        ["/SKILL/2SS"] = 1
    },
    ["isFS"] = true,
    ["cd"] = 6,
    ["desc"] = "A torrent of shredding winds capable of slight knockback."
}
v179["72 Caliber Phoenix"] = v180
local v181 = {
    ["InstantCast"] = true,
    ["moneyreq"] = 0,
    ["stamreq"] = 30,
    ["statreq"] = {
        ["SwordMastery"] = 55,
        ["/SKILL/2SS"] = 2
    },
    ["isFS"] = true,
    ["cd"] = 15,
    ["desc"] = "A vortex of slashes maintained through vertical rotation."
}
v179["Raging Whirl"] = v181
local v182 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 35,
    ["statreq"] = {
        ["SwordMastery"] = 75,
        ["/SKILL/2SS"] = 3
    },
    ["isFS"] = true,
    ["cd"] = 12,
    ["desc"] = "Assume a brief stance that allows the user to strike airborne their next source of harm.",
    ["IsCounter"] = true
}
v179["Tower Climb"] = v182
local v183 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 50,
    ["statreq"] = {
        ["SwordMastery"] = 90,
        ["/SKILL/2SS"] = 4
    },
    ["isFS"] = true,
    ["cd"] = 25,
    ["desc"] = "Ferocious charge followed by a 2-stage spacial incision."
}
v179["Nitoryu Strike"] = v183
local v184 = {
    ["hyperArmor"] = true,
    ["ULT"] = true,
    ["moneyreq"] = 0,
    ["stamreq"] = 100,
    ["statreq"] = {
        ["SwordMastery"] = 125,
        ["/SKILL/2SS"] = 5
    },
    ["isFS"] = true,
    ["cd"] = 90,
    ["desc"] = "A cross-slash performed at the speed of Iai techniques. Executions will trigger a cinematic sequence. "
}
v179["Rashomon Draw"] = v184
local v185 = {}
local v186 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 35,
    ["statreq"] = {
        ["DevilFruitMastery"] = 25
    },
    ["cd"] = 13,
    ["desc"] = "Generate a coarse, crescent blade for a quick swipe. "
}
v185["Desert Cutlass"] = v186
local v187 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 35,
    ["statreq"] = {
        ["DevilFruitMastery"] = 35
    },
    ["cd"] = 15,
    ["desc"] = "An uppercut that leads to a sequence of slashes. "
}
v185["Desert Cutlass: Frenzy"] = v187
local v188 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 35,
    ["statreq"] = {
        ["DevilFruitMastery"] = 50
    },
    ["cd"] = 10,
    ["desc"] = "Mimic flight by transforming the user\'s lower half into a mini dust tornado. ",
    ["IsFlight"] = true
}
v185["Desert Flight"] = v188
local v189 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 45,
    ["statreq"] = {
        ["DevilFruitMastery"] = 60
    },
    ["cd"] = 20,
    ["desc"] = "Spawn a fierce cyclone formed from sand and gale. "
}
v185["Desert Storm"] = v189
local v190 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 55,
    ["statreq"] = {
        ["DevilFruitMastery"] = 80
    },
    ["cd"] = 16,
    ["desc"] = "Send a stream of sand underground that erupts after a delay, splitting apart anyone caught in its path."
}
v185["Desert Spada"] = v190
local v191 = {
    ["ULT"] = true,
    ["moneyreq"] = 0,
    ["stamreq"] = 90,
    ["statreq"] = {
        ["DevilFruitMastery"] = 100
    },
    ["cd"] = 90,
    ["desc"] = "Maximize particle collision by compressing a sandstorm. The resulting explosion is accompanied by violent bursts of electricity. "
}
v185["Desert Railgun"] = v191
local v192 = {}
local v193 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 35,
    ["statreq"] = {
        ["SwordMastery"] = 60
    },
    ["cd"] = 15,
    ["desc"] = "Manifest the sunken remains of an eldritch entity to pull in surrounding enemies.",
    ["InstantCast"] = true
}
v192["Eternal Flow"] = v193
local v194 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 55,
    ["statreq"] = {
        ["SwordMastery"] = 90
    },
    ["cd"] = 25,
    ["desc"] = "Harness the Kraken\'s power in two overwhelming sword motions."
}
v192["Slayer Cross Slash"] = v194
local v195 = {}
local v196 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 40,
    ["statreq"] = {
        ["SwordMastery"] = 60
    },
    ["cd"] = 20,
    ["desc"] = "Puncture and suspend a target before bashing them into the ground. A draining choke is performed instead should the user possess affinity for the sands. "
}
v195["Hook Impale/Dehydrate"] = v196
local v197 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 25,
    ["statreq"] = {
        ["SwordMastery"] = 35
    },
    ["cd"] = 15,
    ["desc"] = "Poisonous vapor emerges to imbue the weapon with deadly afflictions."
}
v195["Activate Poison"] = v197
local v198 = {}
local v199 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 35,
    ["statreq"] = {
        ["SwordMastery"] = 75
    },
    ["cd"] = 15,
    ["desc"] = "Lunge towards the cursor after a brief delay, carrying enemies along. "
}
v198["Cutlass Lunge"] = v199
local v200 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 50,
    ["statreq"] = {
        ["SwordMastery"] = 90
    },
    ["cd"] = 8,
    ["desc"] = "A back-handed upward spiral that propels enemies airborne. "
}
v198["Cutlass Ladder"] = v200
local v201 = {}
local v202 = {
    ["stamreq"] = 0,
    ["statreq"] = {
        ["DevilFruitMastery"] = 0
    },
    ["cd"] = 0,
    ["desc"] = "Exit da karoo!"
}
v201["Exit Mount"] = v202
local v203 = {}
local v204 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 5,
    ["statreq"] = {
        ["DevilFruitMastery"] = 25
    },
    ["cd"] = 35,
    ["desc"] = "bye bye earth"
}
v203["Nobu Meteor"] = v204
local v205 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 5,
    ["statreq"] = {
        ["DevilFruitMastery"] = 25
    },
    ["cd"] = 10,
    ["desc"] = "bye bye earth"
}
v203["Nobu Bat Barrage"] = v205
local v206 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 5,
    ["statreq"] = {
        ["DevilFruitMastery"] = 25
    },
    ["cd"] = 10,
    ["desc"] = "bye bye earth"
}
v203["Nobu Hammer"] = v206
local v207 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 5,
    ["statreq"] = {
        ["DevilFruitMastery"] = 25
    },
    ["cd"] = 0.2,
    ["desc"] = "bye bye earth"
}
v203["Nobu Morph"] = v207
local v208 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 5,
    ["statreq"] = {
        ["DevilFruitMastery"] = 25
    },
    ["cd"] = 15,
    ["desc"] = "bye bye earth"
}
v203["Gates of Nobu"] = v208
local v209 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 5,
    ["statreq"] = {
        ["DevilFruitMastery"] = 25
    },
    ["cd"] = 15,
    ["desc"] = "bye bye earth"
}
v203["Nobu Command"] = v209
local v210 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 5,
    ["statreq"] = {
        ["DevilFruitMastery"] = 25
    },
    ["cd"] = 2,
    ["desc"] = "bye bye earth"
}
v203["Nobu Swap"] = v210
local v211 = {}
local v212 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 35,
    ["statreq"] = {
        ["DevilFruitMastery"] = 25
    },
    ["cd"] = 17,
    ["desc"] = "Summon a tracking hollow that depresses its target."
}
v211["Negative Hollow"] = v212
local v213 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 15,
    ["statreq"] = {
        ["DevilFruitMastery"] = 35
    },
    ["cd"] = 1,
    ["desc"] = "Detonate every explosive hollow attached to an eligible target."
}
v211["Explosive Snap"] = v213
local v214 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 50,
    ["statreq"] = {
        ["DevilFruitMastery"] = 55
    },
    ["cd"] = 18,
    ["desc"] = "Assume remote control of your soul in an experience akin to astral projection. The main body is twice as vulnerable in this state; taking damage will force the soul back to its place."
}
v211["Soul Unbound"] = v214
local v215 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 70,
    ["statreq"] = {
        ["DevilFruitMastery"] = 75
    },
    ["cd"] = 10,
    ["desc"] = "First usage readies a hollow brigade that attaches to their target. Second usage sends them after a designated target."
}
v211["Mini Hollow Barrage"] = v215
local v216 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 50,
    ["statreq"] = {
        ["DevilFruitMastery"] = 80
    },
    ["cd"] = 18,
    ["desc"] = "Levitate every nearby foe with explosive negative hollows and deliver a parting snap."
}
v211["Explosive Snap: Twirl"] = v216
local v217 = {
    ["ULT"] = true,
    ["moneyreq"] = 0,
    ["stamreq"] = 100,
    ["statreq"] = {
        ["DevilFruitMastery"] = 100
    },
    ["cd"] = 60,
    ["desc"] = "Invoke a giant, explosive hollow capable of restraining an enemy."
}
v211["Kamikaze Hollow"] = v217
local v218 = {}
local v219 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 35,
    ["statreq"] = {
        ["SwordMastery"] = 45
    },
    ["cd"] = 13,
    ["desc"] = "Reap vertically in a semi-circular motion."
}
v218["Crimson Slice"] = v219
local v220 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 50,
    ["statreq"] = {
        ["SwordMastery"] = 65
    },
    ["cd"] = 18,
    ["desc"] = "Sever all enemies in your immediate radius after a brief charge."
}
v218["Reaping Slash"] = v220
local v221 = {}
local v222 = {
    ["hyperArmor"] = true,
    ["moneyreq"] = 0,
    ["stamreq"] = 35,
    ["statreq"] = {
        ["SwordMastery"] = 45
    },
    ["cd"] = 9,
    ["desc"] = "Leave behind a shadowy apparition to be swapped with upon recasting."
}
v221["Shadow\'s Mark"] = v222
local v223 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 0,
    ["statreq"] = {
        ["SwordMastery"] = 70
    },
    ["cd"] = 13,
    ["desc"] = "A quick burst of slashes capable of shredding most means of defense."
}
v221["Thousand Strikes"] = v223
local v224 = {}
local v225 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 45,
    ["statreq"] = {
        ["SwordMastery"] = 0
    },
    ["cd"] = 15,
    ["desc"] = "Unleash an aura of doom that compel enemies to flee."
}
v224["Ba\'als Fear"] = v225
local v226 = {}
local v227 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 25,
    ["statreq"] = {
        ["SwordMastery"] = 0
    },
    ["cd"] = 15,
    ["desc"] = "Place a box that will activate when a target is near and fear them."
}
v226["Jack in the Box"] = v227
local v228 = {}
local v229 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["SwordMastery"] = 20
    },
    ["cd"] = 15,
    ["desc"] = "User bits on the candy cane and gets health regen"
}
v228["Prestige Sweet Treat"] = v229
local v230 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["SwordMastery"] = 50
    },
    ["cd"] = 20,
    ["desc"] = "User stabs the floor summoning ice that freezes."
}
v228["Prestige Flash Freeze"] = v230
local v231 = {}
local v232 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["SwordMastery"] = 20
    },
    ["cd"] = 15,
    ["desc"] = "User bits on the candy cane and gets health regen"
}
v231["Festival Thrust"] = v232
local v233 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["SwordMastery"] = 65
    },
    ["cd"] = 15,
    ["desc"] = "User stabs a target and runs with them impaled."
}
v231["Festival Crash"] = v233
local v234 = {
    ["stamreq"] = 60,
    ["statreq"] = {
        ["SwordMastery"] = 85
    },
    ["cd"] = 20,
    ["desc"] = "User stabs the floor summoning a ice wall."
}
v231["Frost Wall"] = v234
__set_list(u5, 33, {v170, v174, v179, v185, v192, v195, v198, v201, v203, v211, v218, v221, v224, v226, v228, v231})
local v235 = {}
local v236 = {
    ["stamreq"] = 55,
    ["statreq"] = {
        ["Strength"] = 50
    },
    ["cd"] = 20,
    ["desc"] = "BASH"
}
v235["Shield Bash"] = v236
local v237 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["Strength"] = 75
    },
    ["cd"] = 35,
    ["desc"] = "User goes into a stance and prepares to reflect all source of damage for 5 seconds. Reflected damage % scales off defense."
}
v235["Sharing is Caring!"] = v237
local v238 = {}
local v239 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["DevilFruitMastery"] = 25
    },
    ["cd"] = 15,
    ["desc"] = "Oppress the target area with a great hail of haki-infused punches.",
    ["InstantCast"] = true
}
v238["Mochi Barrage"] = v239
local v240 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["DevilFruitMastery"] = 45
    },
    ["cd"] = 15,
    ["desc"] = "Project a gigantic mochi fist clad in haki."
}
v238["Power Mochi"] = v240
local v241 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["DevilFruitMastery"] = 55
    },
    ["cd"] = 17,
    ["desc"] = "A six-fold eruption of mochi that impacts surrounding terrain."
}
v238["Mochi Drops"] = v241
local v242 = {
    ["stamreq"] = 50,
    ["statreq"] = {
        ["DevilFruitMastery"] = 65
    },
    ["cd"] = 18,
    ["desc"] = "Transform into a mochi doughnut to bulldoze your victims."
}
v238["Mochi Donut Roll"] = v242
local v243 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["DevilFruitMastery"] = 80
    },
    ["cd"] = 20,
    ["desc"] = "Form a spiraling strip of mochi that fires haki-infused spikes in quick succession."
}
v238["Chestnut Mochi"] = v243
local v244 = {
    ["stamreq"] = 60,
    ["statreq"] = {
        ["DevilFruitMastery"] = 85
    },
    ["cd"] = 14,
    ["desc"] = "Superheat a condensed mochi fist before letting it fly. The attack dissipates shortly but carries tremendous force."
}
v238["Burning Mochi Punch"] = v244
local v245 = {
    ["ULT"] = true,
    ["stamreq"] = 95,
    ["statreq"] = {
        ["DevilFruitMastery"] = 125
    },
    ["cd"] = 75,
    ["desc"] = "Rotate your mochi forearm at dizzying speeds. Enemies caught by the revolving colossus are impaled by haki spikes and crushed under a powerful will."
}
v238["Mochi Buzzcut"] = v245
local v246 = {
    ["hiddenLock"] = true,
    ["moneyreq"] = 0,
    ["stamreq"] = 0,
    ["statreq"] = {
        ["KenMastery"] = 700
    },
    ["cd"] = 0,
    ["desc"] = "The height of observation coupled with this devil fruit allows the user to become completely impervious to most forms of attack."
}
v238["Future Sight"] = v246
local v247 = {}
local v248 = {
    ["stamreq"] = 10,
    ["statreq"] = {
        ["DevilFruitMastery"] = 15
    },
    ["cd"] = 1.5,
    ["desc"] = "Fire a bullet of intertwined threads."
}
v247["String Bullet"] = v248
local v249 = {
    ["stamreq"] = 30,
    ["statreq"] = {
        ["DevilFruitMastery"] = 30
    },
    ["cd"] = 12,
    ["desc"] = "Dash forth with multi-colored slashes."
}
v247["Pentachromatic Strings"] = v249
local v250 = {
    ["InstantCast"] = true,
    ["stamreq"] = 0,
    ["statreq"] = {
        ["DevilFruitMastery"] = 45
    },
    ["cd"] = 0.1,
    ["desc"] = "Sling some strings and travel by pivoting off of your point of contact."
}
v247["Sky Strings"] = v250
local v251 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["DevilFruitMastery"] = 60
    },
    ["cd"] = 15,
    ["desc"] = "Brandishing a fiery whip, erupt a small area in flames."
}
v247["Overheated Whip"] = v251
local v252 = {
    ["stamreq"] = 55,
    ["statreq"] = {
        ["DevilFruitMastery"] = 75
    },
    ["cd"] = 15,
    ["desc"] = "A target is rendered momentarily immobile by strangulating strings. "
}
v247["Parasitic Strings"] = v252
local v253 = {
    ["InstantCast"] = true,
    ["ULT"] = true,
    ["stamreq"] = 75,
    ["statreq"] = {
        ["DevilFruitMastery"] = 85
    },
    ["cd"] = 75,
    ["desc"] = "Create a large enclosure that eviscerates its prisoners."
}
v247.Birdcage = v253
local v254 = {}
local v255 = {
    ["percentStamina"] = v4.percentStamina,
    ["baseStamina"] = v4.baseStamina,
    ["statreq"] = {
        ["Strength"] = 0
    },
    ["stamreq"] = 0,
    ["cd"] = 0.2,
    ["desc"] = "The Geppo allows the users to actually jump off the air itself, allowing them to stay in the air for much longer than usual"
}
v254["Sky Walk2"] = v255
local v256 = {}
local v257 = {
    ["stamreq"] = 40,
    ["statreq"] = {
        ["SwordMastery"] = 35
    },
    ["cd"] = 20,
    ["desc"] = "Call a blessing, healing you and all party members around you."
}
v256["Cupid\'s Blessing"] = v257
local v258 = {
    ["stamreq"] = 55,
    ["statreq"] = {
        ["SwordMastery"] = 55
    },
    ["cd"] = 15,
    ["desc"] = "Call a thunder cloud which strikes targets that are nearby"
}
v256["Cupid\'s Wrath"] = v258
local v259 = {}
local v260 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["SwordMastery"] = 40
    },
    ["cd"] = 10,
    ["desc"] = "Spin and slash all targets around you."
}
v259.Decimation = v260
local v261 = {
    ["stamreq"] = 40,
    ["statreq"] = {
        ["SwordMastery"] = 55
    },
    ["cd"] = 15,
    ["desc"] = "Pulls a target towards you with axe."
}
v259["Get over here!"] = v261
local v262 = {}
local v263 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["DevilFruitMastery"] = 15
    },
    ["cd"] = 15,
    ["desc"] = "Attack by dissolving into bat-like shadows."
}
v262["Bat Tornado"] = v263
local v264 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["DevilFruitMastery"] = 35
    },
    ["cd"] = 16,
    ["desc"] = "Spawn a box of shadows at the cursor that will slam down on those entrapped.",
    ["InstantCast"] = true
}
v262["Shadow Trap"] = v264
local v265 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["DevilFruitMastery"] = 55
    },
    ["cd"] = 9,
    ["desc"] = "The user dematerializes for a brief moment to enable rapid movement.",
    ["InstantCast"] = true
}
v262["Fleeing Shadows"] = v265
local v266 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["DevilFruitMastery"] = 75
    },
    ["cd"] = 13,
    ["desc"] = "Submerge in shifting shadows and release a massive column of umbral matter on exit.",
    ["InstantCast"] = true,
    ["Grounded"] = true
}
v262["Burrowing Shadows"] = v266
local v267 = {
    ["stamreq"] = 55,
    ["statreq"] = {
        ["DevilFruitMastery"] = 85
    },
    ["cd"] = 20,
    ["desc"] = "A ghastly hand sprouts from the cursor, grasping and crushing anyone in its immediate radius.",
    ["InstantCast"] = true
}
v262["Shadows Grasp"] = v267
local v268 = {
    ["stamreq"] = 75,
    ["ULT"] = true,
    ["statreq"] = {
        ["DevilFruitMastery"] = 125
    },
    ["cd"] = 85,
    ["desc"] = "Materialize a reflection of oneself from beyond the umbra."
}
v262["Sillhouette\'s Assault"] = v268
local v269 = {}
local v270 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["SwordMastery"] = 35
    },
    ["cd"] = 12,
    ["desc"] = "The scissors are spun at high speeds to facilitate multiple incisions."
}
v269["Blade Whirl"] = v270
local v271 = {
    ["stamreq"] = 55,
    ["statreq"] = {
        ["SwordMastery"] = 55
    },
    ["cd"] = 15,
    ["desc"] = "Skewer the victim with both blades before punching them away. A shadow execution is performed instead should the user possess affinity for the shade."
}
v269["Shadow Extraction/Scissor Impale"] = v271
local v272 = {}
local v273 = {
    ["hyperArmor"] = true,
    ["stamreq"] = 35,
    ["statreq"] = {
        ["DevilFruitMastery"] = 25
    },
    ["cd"] = 10,
    ["desc"] = "Fire a paw-shaped bubble of compressed air."
}
v272["Paw Cannon"] = v273
local v274 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["DevilFruitMastery"] = 35
    },
    ["cd"] = 13,
    ["desc"] = "Emit an omnidirectional shockwave to repel attacks.",
    ["IsCounter"] = true
}
v272["Shock Repel"] = v274
local v275 = {
    ["stamreq"] = 100,
    ["statreq"] = {
        ["DevilFruitMastery"] = 55
    },
    ["cd"] = 15,
    ["desc"] = "Place an anchoring bubble that can be returned to upon recast."
}
v272.Rendezvous = v275
local v276 = {
    ["stamreq"] = 55,
    ["statreq"] = {
        ["DevilFruitMastery"] = 65
    },
    ["cd"] = 13,
    ["desc"] = "Compress pain and fatigue into an exploding bubble."
}
v272["Paw Bomb"] = v276
local v277 = {
    ["stamreq"] = 50,
    ["statreq"] = {
        ["DevilFruitMastery"] = 75
    },
    ["cd"] = 15,
    ["desc"] = "Tiny bubbles of air, launched consecutively."
}
v272["Paw Barrage"] = v277
local v278 = {
    ["stamreq"] = 90,
    ["ULT"] = true,
    ["statreq"] = {
        ["DevilFruitMastery"] = 95
    },
    ["cd"] = 70,
    ["desc"] = "Surrounding air is compressed numerous times to form a bubble of mass destruction. Damage is reduced during charge."
}
v272["Ursus Shock"] = v278
local v279 = {
    ["stamreq"] = 10,
    ["statreq"] = {
        ["DevilFruitMastery"] = 0
    },
    ["cd"] = 0.5,
    ["desc"] = "Passive: Dash replaced with teleport."
}
v272.PawDash = v279
local v280 = {}
local v281 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["SwordMastery"] = 35
    },
    ["cd"] = 9,
    ["desc"] = "Shusui\'s essence is condensed to form a crescent-shaped flying slash."
}
v280["Crescent Slash"] = v281
local v282 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["SwordMastery"] = 75
    },
    ["cd"] = 16,
    ["desc"] = "Slash vertically in three consecutive spins."
}
v280["Triple Ripple"] = v282
local v283 = {}
local v284 = {
    ["stamreq"] = 70,
    ["statreq"] = {
        ["SwordMastery"] = 55
    },
    ["cd"] = 15,
    ["desc"] = "Counter by freezing the immediate assailant with an otherworldy chill.",
    ["IsCounter"] = true
}
v283["Soul Parade"] = v284
local v285 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["SwordMastery"] = 75
    },
    ["cd"] = 15,
    ["desc"] = "Shift toward the cursor and inflict multiple lacerations on foes en route."
}
v283["Drawing Song"] = v285
local v286 = {}
local v287 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["Strength"] = 35
    },
    ["cd"] = 9,
    ["desc"] = "Grapple and throw an opponent over yourself, back-first. This incredible feat scales with strength."
}
v286["Over Shoulder Slam"] = v287
local v288 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["Strength"] = 65
    },
    ["cd"] = 15,
    ["desc"] = "Leap a designated distance and shatter the earth on landing. Tremendous strength is necessary to perfect this technique."
}
v286["Grand Entrance Slam"] = v288
local v289 = {}
local v290 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["SwordMastery"] = 35
    },
    ["cd"] = 14,
    ["desc"] = "Melodies to chill the soul."
}
v289["Freezing Tune"] = v290
local v291 = {}
local v292 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["SwordMastery"] = 35
    },
    ["cd"] = 13,
    ["desc"] = "Rev up the embers of life! Regain missing health at a set percentage."
}
v291["Amp It Up!"] = v292
local v293 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["SwordMastery"] = 55
    },
    ["cd"] = 15,
    ["desc"] = "Strings imbued with soulful vigor emit an attack of sound and frost."
}
v291["Power Chord"] = v293
local v294 = {}
local v295 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["DevilFruitMastery"] = 35
    },
    ["cd"] = 24,
    ["desc"] = "Release a wave of frigid air to freeze enemies where they stand."
}
v294["Chilling Soul"] = v295
local v296 = {
    ["stamreq"] = 40,
    ["statreq"] = {
        ["DevilFruitMastery"] = 55
    },
    ["cd"] = 15,
    ["desc"] = "Escape the confinements of mortal flesh to seek out foes. Those contacted will freeze to their bones."
}
v294["Soul Form"] = v296
local v297 = {
    ["stamreq"] = 20,
    ["statreq"] = {
        ["DevilFruitMastery"] = 65
    },
    ["cd"] = 15,
    ["desc"] = "Approach your enemies with comedic intent. Transportation like no other."
}
v294.Skedaddle = v297
local v298 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["DevilFruitMastery"] = 80
    },
    ["cd"] = 12,
    ["desc"] = "Project a series of kicks using the player\'s partially detached spiritual avatar."
}
v294["Soul Assault"] = v298
local v299 = {
    ["stamreq"] = 100,
    ["statreq"] = {
        ["DevilFruitMastery"] = 120
    },
    ["cd"] = 1,
    ["desc"] = "A mutiny against the end. Resurrect on death with handicaps."
}
v294["Death Defied"] = v299
local v300 = {
    ["stamreq"] = 125,
    ["ULT"] = true,
    ["statreq"] = {
        ["DevilFruitMastery"] = 90
    },
    ["cd"] = 50,
    ["desc"] = "Summon an otherworldy avatar of the user\'s soul that sends surrounding enemies into a fearful frenzy."
}
v294["Soul King Roar"] = v300
local v301 = {}
local v302 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["Strength"] = 35
    },
    ["cd"] = 12,
    ["desc"] = "Rev up the embers of life! Regain missing health at a set percentage."
}
v301["Bone Frenzy"] = v302
local v303 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["Strength"] = 55
    },
    ["cd"] = 15,
    ["desc"] = "Strings imbued with soulful vigor emit an attack of sound and frost."
}
v301["Rib Smash"] = v303
__set_list(u5, 49, {v235, v238, v247, v254, v256, v259, v262, v269, v272, v280, v283, v286, v289, v291, v294, v301})
local v304 = {}
local v305 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["DevilFruitMastery"] = 15
    },
    ["cd"] = 12,
    ["desc"] = "Summon a surge of darkness to entrap others around you."
}
v304["Black Hole"] = v305
local v306 = {
    ["stamreq"] = 40,
    ["statreq"] = {
        ["DevilFruitMastery"] = 25
    },
    ["cd"] = 16,
    ["desc"] = "Create a point of attraction that engulfs and overwhelms its prey."
}
v304["Cruel Burst"] = v306
local v307 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["DevilFruitMastery"] = 35
    },
    ["cd"] = 25,
    ["desc"] = "Enter a temporary state of formlessness to mimic flight.",
    ["InstantCast"] = true,
    ["IsFlight"] = true
}
v304["Abyssal Form"] = v307
local v308 = {
    ["stamreq"] = 30,
    ["statreq"] = {
        ["DevilFruitMastery"] = 55
    },
    ["cd"] = 18,
    ["desc"] = "Enemies are drawn closer by plumes of darkness.",
    ["InstantCast"] = true
}
v304["Black Vortex"] = v308
local v309 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["DevilFruitMastery"] = 65
    },
    ["cd"] = 12,
    ["desc"] = "Open a rift to the depths of darkness that consumes surrounding matter. Crushed debris is then released proportional to the mass consumed."
}
v304["Dark Liberation"] = v309
local v310 = {
    ["stamreq"] = 100,
    ["ULT"] = true,
    ["statreq"] = {
        ["DevilFruitMastery"] = 95
    },
    ["cd"] = 99,
    ["desc"] = "Darkness insurmountable coalesce to form a destructive singularity."
}
v304["Black Star"] = v310
local v311 = {}
local v312 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["FightingStyleMastery"] = 15,
        ["/SKILL/DragonClaw"] = 1
    },
    ["cd"] = 12,
    ["desc"] = "Charge up a punch and knockback enemies in front of you.",
    ["hyperArmor"] = true
}
v311["Dragon Fist"] = v312
local v313 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["FightingStyleMastery"] = 25,
        ["/SKILL/DragonClaw"] = 2
    },
    ["cd"] = 14,
    ["desc"] = "Break the ground under you knocking enemies into the air"
}
v311["Dragon Breath"] = v313
local v314 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["FightingStyleMastery"] = 45,
        ["/SKILL/DragonClaw"] = 3
    },
    ["cd"] = 45,
    ["desc"] = "[HOLD] Enter a stance, that applies a brief damage boost to your next attacks"
}
v311["Dragon Claw Stance"] = v314
local v315 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["FightingStyleMastery"] = 55,
        ["/SKILL/DragonClaw"] = 4
    },
    ["cd"] = 16,
    ["desc"] = "[PRESS] To perform a rapid slash barrage"
}
v311["Dragon Claw Slash"] = v315
local v316 = {
    ["stamreq"] = 70,
    ["statreq"] = {
        ["FightingStyleMastery"] = 65,
        ["/SKILL/DragonClaw"] = 5
    },
    ["cd"] = 18,
    ["desc"] = "Rush forward bashing the first enemy hit into the ground"
}
v311["Dragon Rush"] = v316
local v317 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["FightingStyleMastery"] = 85,
        ["/SKILL/DragonClaw"] = 6
    },
    ["cd"] = 20,
    ["desc"] = "Enter a stance that will counter the next enemy attack",
    ["IsCounter"] = true
}
v311["Reverse Dragon"] = v317
local v318 = {
    ["stamreq"] = 100,
    ["ULT"] = true,
    ["statreq"] = {
        ["FightingStyleMastery"] = 100,
        ["/SKILL/DragonClaw"] = 7
    },
    ["cd"] = 90,
    ["desc"] = "Charge up an ultimate skull crushing blow"
}
v311["Dragon Skull Crusher"] = v318
local v319 = {}
local v320 = {
    ["stamreq"] = 60,
    ["statreq"] = {
        ["SwordMastery"] = 35
    },
    ["cd"] = 20,
    ["desc"] = "Release 3 energy slashes"
}
v319["THE TROXX"] = v320
local v321 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["SwordMastery"] = 75
    },
    ["cd"] = 30,
    ["desc"] = "Impale a target and drain their life, healing yourself for a portion."
}
v319["Soul Eater"] = v321
local v322 = {}
local v323 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["Strength"] = 35
    },
    ["cd"] = 18,
    ["desc"] = "Rush foward rapidly spinning your pipe and damaging enemies near"
}
v322["Pipe Rush"] = v323
local v324 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["Strength"] = 65
    },
    ["cd"] = 17,
    ["desc"] = "BEAT DOWN"
}
v322["Pipe Beatdown"] = v324
local v325 = {}
local v326 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["GunMastery"] = 35
    },
    ["cd"] = 12,
    ["desc"] = "Designates three patches of terrain in front of the player where explosive outbursts will emerge."
}
v325["Explosive Field"] = v326
local v327 = {
    ["transformation"] = true,
    ["stamreq"] = 75,
    ["statreq"] = {
        ["GunMastery"] = 60
    },
    ["cd"] = 60,
    ["desc"] = "Fire an ultra-accurate, explosive projectile that scales with charge. The resulting blast is nigh unstoppable."
}
v325["SUPER MEGA DEATH ROCKET"] = v327
local v328 = {}
local v329 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["GunMastery"] = 35
    },
    ["cd"] = 12,
    ["desc"] = "Designates three patches of terrain in front of the player where explosive outbursts will emerge."
}
v328["Prestige Explosive Field"] = v329
local v330 = {
    ["stamreq"] = 75,
    ["statreq"] = {
        ["GunMastery"] = 60
    },
    ["cd"] = 60,
    ["desc"] = "Fire an ultra-accurate, explosive projectile that scales with charge. The resulting blast is nigh unstoppable."
}
v328["PRESTIGE SUPER MEGA DEATH ROCKET"] = v330
local v331 = {}
local v332 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["SwordMastery"] = 25
    },
    ["cd"] = 12,
    ["desc"] = "The next victim of this spear shall become firework, launched by its skyrocket in the spirit of celebration."
}
v331["PRESTIGE TO THE MOON!"] = v332
local v333 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["SwordMastery"] = 45
    },
    ["cd"] = 17,
    ["desc"] = "Manuever the rocket-propelled spear to blast your target away."
}
v331["Prestige Firework Rush"] = v333
local v334 = {}
local v335 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["SwordMastery"] = 25
    },
    ["cd"] = 12,
    ["desc"] = "The next victim of this spear shall become firework, launched by its skyrocket in the spirit of celebration."
}
v334["TO THE MOON!"] = v335
local v336 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["SwordMastery"] = 45
    },
    ["cd"] = 17,
    ["desc"] = "Manuever the rocket-propelled spear to blast your target away."
}
v334["Firework Rush"] = v336
local v337 = {}
local v338 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["DevilFruitMastery"] = 10
    },
    ["cd"] = 12,
    ["desc"] = "A deadly combo designed to overwhelm its victims. The receiver is lifted, battered, and dispatched with ease."
}
v337["Triple Talon Kick"] = v338
local v339 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["DevilFruitMastery"] = 25
    },
    ["cd"] = 14,
    ["desc"] = "With talons aflame, set off a frenzy of kicks to buffet and scorch your foes."
}
v337["Talon Barrage"] = v339
local v340 = {
    ["stamreq"] = 15,
    ["statreq"] = {
        ["DevilFruitMastery"] = 45
    },
    ["cd"] = 15,
    ["desc"] = "Undying flames adorn the Phoenix. Every last malady is burnt away."
}
v337["Phoenix Pyreapple"] = v340
local v341 = {
    ["transformation"] = true,
    ["stamreq"] = 15,
    ["statreq"] = {
        ["DevilFruitMastery"] = 55
    },
    ["cd"] = 1,
    ["desc"] = "Soar to the sky on wings of blue. On hold, assume the mythical majesty in its entirety."
}
v337["Phoenix Transformation"] = v341
local v342 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["DevilFruitMastery"] = 65
    },
    ["cd"] = 20,
    ["desc"] = "Maintain a fiery bulwark to nullify most damage."
}
v337["Immortal Thistle"] = v342
local v343 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["DevilFruitMastery"] = 45
    },
    ["cd"] = 18,
    ["desc"] = "Seize upon the Phoenix\'s wrath to deliver a charge of cometic might."
}
v337["Phoenix Brand"] = v343
local v344 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["DevilFruitMastery"] = 55
    },
    ["cd"] = 12,
    ["desc"] = "Unleash a spiraling blaze upon the earth. The number of projectiles is tripled while fully transformed."
}
v337["Phoenix Burst"] = v344
local v345 = {
    ["stamreq"] = 75,
    ["ULT"] = true,
    ["statreq"] = {
        ["DevilFruitMastery"] = 90
    },
    ["cd"] = 65,
    ["desc"] = "In two fell swoops, swipe your foes off their feet and lay waste to those below.",
    ["InstantCast"] = true
}
v337["Phoenix Dive Bomb"] = v345
local v346 = {
    ["stamreq"] = 20,
    ["statreq"] = {
        ["DevilFruitMastery"] = 55
    },
    ["cd"] = 1,
    ["desc"] = "roll"
}
v337["Phoenix Carry"] = v346
local v347 = {}
local v348 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["SwordMastery"] = 25
    },
    ["cd"] = 14,
    ["desc"] = "Imbue the chilling daggers with piercing cold. Repeated strikes will freeze the opponent."
}
v347["Iceborn Aura"] = v348
local v349 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["SwordMastery"] = 45
    },
    ["cd"] = 25,
    ["desc"] = "The user is made nexus amidst a whirlwind of glacial blades."
}
v347["Iceborn Death Lotus"] = v349
local v350 = {}
local v351 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["SwordMastery"] = 25
    },
    ["cd"] = 14,
    ["desc"] = "Layers of frost form and shatter as the user drills forward in a vigorous lunge."
}
v350["Iceborn Lunge"] = v351
local v352 = {
    ["stamreq"] = 31.499999999999996,
    ["statreq"] = {
        ["SwordMastery"] = 45
    },
    ["cd"] = 17,
    ["desc"] = "Launch three frozen shards to extend the rapier\'s icy sting.",
    ["InstantCast"] = true
}
v350["Iceborn Shards"] = v352
local v353 = {}
local v354 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["DevilFruitMastery"] = 15
    },
    ["cd"] = 14,
    ["desc"] = "Summon an advancing vortex of snow to occupy your opponents."
}
v353["Snow Gust"] = v354
local v355 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["DevilFruitMastery"] = 25
    },
    ["cd"] = 20,
    ["desc"] = "Choked of breath and warmth, the victim is freed only to shatter in a merciless slam."
}
v353["Frost Bite"] = v355
local v356 = {
    ["stamreq"] = 55,
    ["statreq"] = {
        ["DevilFruitMastery"] = 55
    },
    ["cd"] = 20,
    ["desc"] = "Assume the properties of snow to overcome obstacles.",
    ["InstantCast"] = true
}
v353["Snow Reformation"] = v356
local v357 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["DevilFruitMastery"] = 65
    },
    ["cd"] = 20,
    ["desc"] = "A sentient helper that will nail an opponent with snowballs until it melts."
}
v353["Snow Bunny Turret"] = v357
local v358 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["DevilFruitMastery"] = 75
    },
    ["cd"] = 20,
    ["desc"] = "Form a small but deadly storm of icicles to dice the opposition."
}
v353["Snow Storm"] = v358
local v359 = {
    ["stamreq"] = 75,
    ["ULT"] = true,
    ["statreq"] = {
        ["DevilFruitMastery"] = 80
    },
    ["cd"] = 75,
    ["desc"] = "Enemies are rendered helpless by an expanding snowstorm."
}
v353["Snow Blizzard"] = v359
local v360 = {}
local v361 = {
    ["stamreq"] = 15,
    ["statreq"] = {
        ["DevilFruitMastery"] = 25
    },
    ["cd"] = 6,
    ["desc"] = "Spit a concentrated ball of venom to poison your foes."
}
v360["Venom Spit"] = v361
local v362 = {
    ["stamreq"] = 40,
    ["statreq"] = {
        ["DevilFruitMastery"] = 35
    },
    ["cd"] = 17,
    ["desc"] = "Manipulate vast amounts of venom and form it to a hydra that chases your foes.",
    ["InstantCast"] = true
}
v360["Venom Hydra"] = v362
local v363 = {
    ["stamreq"] = 20,
    ["statreq"] = {
        ["DevilFruitMastery"] = 45
    },
    ["cd"] = 20,
    ["desc"] = "Travel through your venom hydra to approach your enemies.",
    ["InstantCast"] = true
}
v360["Venom Road"] = v363
local v364 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["DevilFruitMastery"] = 55
    },
    ["cd"] = 12,
    ["desc"] = "Discharge your venom in a powerful blast that arround you."
}
v360["Venom Discharge"] = v364
local v365 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["DevilFruitMastery"] = 65
    },
    ["cd"] = 25,
    ["desc"] = "Produce a dangerous cloud of venom to harm foes surrounding you."
}
v360["Venom Aura"] = v365
local v366 = {
    ["transformation"] = true,
    ["stamreq"] = 125,
    ["ULT"] = true,
    ["statreq"] = {
        ["DevilFruitMastery"] = 90
    },
    ["cd"] = 25,
    ["desc"] = "Manipulate your venom to create a demonic avatar which immensely increases your fighting capabilities."
}
v360["Venom Demon"] = v366
local v367 = {
    ["stamreq"] = 100,
    ["statreq"] = {
        ["DevilFruitMastery"] = 95
    },
    ["cd"] = 35,
    ["desc"] = "Charge forward with your body to decimate all in your way."
}
v360["Venom Rush"] = v367
local v368 = {
    ["stamreq"] = 75,
    ["statreq"] = {
        ["DevilFruitMastery"] = 105
    },
    ["cd"] = 35,
    ["desc"] = "Produce an even more dangerous cloud of poison to wither surrounding foes."
}
v360["Venom Poisonous Gas"] = v368
local v369 = {
    ["stamreq"] = 55,
    ["statreq"] = {
        ["DevilFruitMastery"] = 115
    },
    ["cd"] = 18,
    ["desc"] = "Create a powerful poisonious slam downwards."
}
v360["Venom Slam"] = v369
local v370 = {
    ["stamreq"] = 55,
    ["statreq"] = {
        ["DevilFruitMastery"] = 120
    },
    ["cd"] = 25,
    ["desc"] = "Ensnare a victim and bring them into your venomous embrace."
}
v360["Venom Grab"] = v370
local v371 = {}
local v372 = {
    ["stamreq"] = 15,
    ["statreq"] = {
        ["DevilFruitMastery"] = 5
    },
    ["cd"] = 25,
    ["desc"] = "Morph your limbs into springs to enhance your combative capabilities."
}
v371["Spring Mode"] = v372
local v373 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["DevilFruitMastery"] = 25
    },
    ["cd"] = 16,
    ["desc"] = "Bound forward and drag an enemy across the ground."
}
v371["Spring Facebreaker"] = v373
local v374 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["DevilFruitMastery"] = 30
    },
    ["cd"] = 14,
    ["desc"] = "Leap into the air using the power of your springy limbs."
}
v371["Spring Leap"] = v374
local v375 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["DevilFruitMastery"] = 35
    },
    ["cd"] = 19,
    ["desc"] = "Move forward in a zig-zag while attacking your foes."
}
v371["Spring Blitz"] = v375
local v376 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["DevilFruitMastery"] = 55
    },
    ["cd"] = 25,
    ["desc"] = "Compress your springs to charge forward and knockback enemies."
}
v371["Death Knock"] = v376
local v377 = {
    ["stamreq"] = 65,
    ["ULT"] = true,
    ["statreq"] = {
        ["DevilFruitMastery"] = 65
    },
    ["cd"] = 65,
    ["desc"] = "Unleash a powerful dropkick to devastate your opponent."
}
v371["Coil Crusher"] = v377
local v378 = {
    ["stamreq"] = 15,
    ["statreq"] = {
        ["DevilFruitMastery"] = 0
    },
    ["DashSkill"] = true,
    ["cd"] = 0.5,
    ["desc"] = "Release a wave of frigid air to freeze enemies where they stand."
}
v371["Spring Dash"] = v378
local v379 = {}
local v380 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["DevilFruitMastery"] = 25
    },
    ["cd"] = 10,
    ["desc"] = "Release orbs which replenish your allies health."
}
v379["Healing Orb"] = v380
local v381 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["DevilFruitMastery"] = 35
    },
    ["cd"] = 20,
    ["desc"] = "Conjure a healing orb that floats by your side and heals allies"
}
v379["Healing Support"] = v381
local v382 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["DevilFruitMastery"] = 45
    },
    ["cd"] = 50,
    ["desc"] = "Create a field that rapidly regenerates health when inside."
}
v379["Healing Field"] = v382
local v383 = {}
local v384 = {
    ["stamreq"] = 15,
    ["statreq"] = {
        ["DevilFruitMastery"] = 15
    },
    ["cd"] = 1,
    ["desc"] = "Create a spherical space around your opponents that allows you to begin your operation."
}
v383.Room = v384
local v385 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["DevilFruitMastery"] = 25
    },
    ["cd"] = 20,
    ["desc"] = "Tear up the ground to release a spike that launches your foes into the air.",
    ["InstantCast"] = true
}
v383.Thorn = v385
local v386 = {
    ["stamreq"] = 55,
    ["statreq"] = {
        ["DevilFruitMastery"] = 35
    },
    ["cd"] = 8,
    ["desc"] = "Rapidly switch places with any target of your choosing inside the room.",
    ["InstantCast"] = true
}
v383.Shambles = v386
local v387 = {
    ["stamreq"] = 10,
    ["statreq"] = {
        ["DevilFruitMastery"] = 45
    },
    ["cd"] = 15,
    ["desc"] = "Tear up the ground to create floating debris that can be launched at devastating speeds.",
    ["InstantCast"] = true
}
v383.Tact = v387
local v388 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["DevilFruitMastery"] = 55
    },
    ["cd"] = 20,
    ["desc"] = "Grab your opponent and deliver a strong electric surge.",
    ["InstantCast"] = true
}
v383["Counter Shock"] = v388
local v389 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["DevilFruitMastery"] = 65
    },
    ["cd"] = 18,
    ["desc"] = "Charge electricity into a blade and deliver multiple high speed slashes."
}
v383["Radio Knife"] = v389
local v390 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["DevilFruitMastery"] = 70
    },
    ["cd"] = 18,
    ["desc"] = "Release a powerful strike that pierces your foes."
}
v383["Injection Shot"] = v390
local v391 = {
    ["stamreq"] = 55,
    ["statreq"] = {
        ["DevilFruitMastery"] = 85
    },
    ["cd"] = 23,
    ["desc"] = "Strike forward and grab your opponents heart to deal devastating damage."
}
v383.Mes = v391
local v392 = {
    ["stamreq"] = 0,
    ["statreq"] = {
        ["DevilFruitMastery"] = 55
    },
    ["cd"] = 1,
    ["desc"] = "Discard abilites and gain new ones to continue your operation."
}
v383["Surgeon Mode"] = v392
local v393 = {
    ["stamreq"] = 75,
    ["ULT"] = true,
    ["statreq"] = {
        ["DevilFruitMastery"] = 95
    },
    ["cd"] = 60,
    ["desc"] = "Pierce your opponent with a blade of pure energy that destroys your victims from the inside."
}
v383["Gamma Knife"] = v393
__set_list(u5, 65, {v304, v311, v319, v322, v325, v328, v331, v334, v337, v347, v350, v353, v360, v371, v379, v383})
local v394 = {}
local v395 = {
    ["moneyreq"] = 1,
    ["stamreq"] = 35,
    ["statreq"] = {
        ["FightingStyleMastery"] = 15,
        ["/SKILL/Cyborg"] = 1
    },
    ["cd"] = 20,
    ["desc"] = "Unleash a barrage of high speed punches to devastate your foes."
}
v394["Machine Gun Blows"] = v395
local v396 = {
    ["moneyreq"] = 1,
    ["stamreq"] = 30,
    ["statreq"] = {
        ["FightingStyleMastery"] = 25,
        ["/SKILL/Cyborg"] = 2
    },
    ["cd"] = 14,
    ["desc"] = "Release a powerful laser pulse at your foes."
}
v394["Laser Pulsar"] = v396
local v397 = {
    ["moneyreq"] = 1,
    ["stamreq"] = 55,
    ["statreq"] = {
        ["FightingStyleMastery"] = 45,
        ["/SKILL/Cyborg"] = 3
    },
    ["cd"] = 15,
    ["desc"] = "Use your thrusters to take flight.",
    ["IsFlight"] = true
}
v394["Cyborg Flight"] = v397
local v398 = {
    ["moneyreq"] = 1,
    ["stamreq"] = 45,
    ["statreq"] = {
        ["FightingStyleMastery"] = 65,
        ["/SKILL/Cyborg"] = 4
    },
    ["cd"] = 25,
    ["desc"] = "Repair yourself to regenerate health quicky.",
    ["Grounded"] = true
}
v394["Self Repair"] = v398
local v399 = {
    ["moneyreq"] = 1,
    ["stamreq"] = 35,
    ["statreq"] = {
        ["FightingStyleMastery"] = 75,
        ["/SKILL/Cyborg"] = 5
    },
    ["cd"] = 19,
    ["desc"] = "Fire a barrage of missles to strike your enemies from afar."
}
v394["Missle Shower"] = v399
local v400 = {
    ["InstantCast"] = true,
    ["moneyreq"] = 1,
    ["ULT"] = true,
    ["stamreq"] = 100,
    ["statreq"] = {
        ["FightingStyleMastery"] = 100,
        ["/SKILL/Cyborg"] = 6
    },
    ["cd"] = 75,
    ["desc"] = "Lock onto a target and rapidly approach them before dealing a devastating blow."
}
v394["Obliteration Rush"] = v400
local v401 = {}
local v402 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["SwordMastery"] = 25
    },
    ["cd"] = 20,
    ["desc"] = "Deliver multiple slashes forward before sheathing the blade."
}
v401.Amputate = v402
local v403 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["SwordMastery"] = 35
    },
    ["cd"] = 16,
    ["desc"] = "Unleash the Kikoku in a buzzsaw motion to vertically slash your enemies."
}
v401["Sterben Linie"] = v403
local v404 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["SwordMastery"] = 45,
        ["DF"] = "Ope-Ope"
    },
    ["cd"] = 17,
    ["desc"] = "Harness the power of the Ope to deliver horizontal slashes with the Kikoku."
}
v401["Sterben Kreis"] = v404
local v405 = {
    ["stamreq"] = 55,
    ["statreq"] = {
        ["SwordMastery"] = 55,
        ["DF"] = "Ope-Ope"
    },
    ["cd"] = 20,
    ["desc"] = "Harness the power of the Ope fruit to slash an opponents torso."
}
v401["Amputating Cleave"] = v405
local v406 = {}
local v407 = {
    ["stamreq"] = 15,
    ["statreq"] = {
        ["DevilFruitMastery"] = 0
    },
    ["cd"] = 1,
    ["desc"] = "The user\'s enhanced disposition allows for bursts of speed."
}
v406.Gear2Dash = v407
local v408 = {
    ["stamreq"] = 15,
    ["statreq"] = {
        ["DevilFruitMastery"] = 25
    },
    ["cd"] = 1,
    ["desc"] = "A punch faster than the eye can follow."
}
v406["Jet Pistol"] = v408
local v409 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["DevilFruitMastery"] = 35
    },
    ["cd"] = 15,
    ["desc"] = "Evade the next instance of damage and trample its source."
}
v406["Jet Stomp"] = v409
local v410 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["DevilFruitMastery"] = 55
    },
    ["cd"] = 12,
    ["desc"] = "Propel yourself towards a grappled point and deal damage to foes on site."
}
v406["Jet Rocket"] = v410
local v411 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["DevilFruitMastery"] = 75
    },
    ["cd"] = 18,
    ["desc"] = "A typical pistol punch imbued with flames of will. Its might reverberates in a fiery explosion."
}
v406["Red Hawk"] = v411
local v412 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["DevilFruitMastery"] = 85
    },
    ["cd"] = 12,
    ["desc"] = "An untold amount of strikes besiege the enemy."
}
v406["Jet Gatling"] = v412
local v413 = {
    ["stamreq"] = 85,
    ["ULT"] = true,
    ["statreq"] = {
        ["DevilFruitMastery"] = 120
    },
    ["cd"] = 85,
    ["desc"] = "Appear above the target and let fall a punch of astronomical proportions."
}
v406["Elephant Gun"] = v413
local v414 = {
    ["transformation"] = true,
    ["stamreq"] = 0,
    ["statreq"] = {
        ["Gear2"] = 6
    },
    ["cd"] = 12,
    ["desc"] = "Manipulate your unique physiology to raise blood flow, oxygen, and nutrients to a critical point."
}
v406["Gear 2 Transformation"] = v414
local v415 = {}
local v416 = {
    ["InstantCast"] = true,
    ["moneyreq"] = 10,
    ["stamreq"] = 15,
    ["statreq"] = {
        ["FightingStyleMastery"] = 15,
        ["/SKILL/Dullahan"] = 1
    },
    ["cd"] = 9,
    ["desc"] = "Summon orbs of spirit fire that track down enemies."
}
v415["Will O\' Wisp"] = v416
local v417 = {
    ["moneyreq"] = 20,
    ["stamreq"] = 25,
    ["statreq"] = {
        ["FightingStyleMastery"] = 25,
        ["/SKILL/Dullahan"] = 2
    },
    ["cd"] = 18,
    ["desc"] = "Grab hold of an opponent to instill a primal fear inside them."
}
v415["Fear Inducement"] = v417
local v418 = {
    ["InstantCast"] = true,
    ["moneyreq"] = 30,
    ["stamreq"] = 35,
    ["statreq"] = {
        ["FightingStyleMastery"] = 35,
        ["/SKILL/Dullahan"] = 3
    },
    ["cd"] = 15,
    ["desc"] = "Toss your own head as an explosive projectile."
}
v415["Head Throw"] = v418
local v419 = {
    ["InstantCast"] = true,
    ["moneyreq"] = 40,
    ["stamreq"] = 75,
    ["statreq"] = {
        ["FightingStyleMastery"] = 65,
        ["/SKILL/Dullahan"] = 4
    },
    ["cd"] = 60,
    ["desc"] = "Ressurect the dead to fight for you."
}
v415.Resurrection = v419
local v420 = {
    ["InstantCast"] = true,
    ["moneyreq"] = 50,
    ["ULT"] = true,
    ["stamreq"] = 100,
    ["statreq"] = {
        ["FightingStyleMastery"] = 75,
        ["/SKILL/Dullahan"] = 5
    },
    ["cd"] = 80,
    ["desc"] = "Summon shadows that charge forward alongside you and fear enemies on arrival."
}
v415["Onslaught of Shadows"] = v420
local v421 = {}
local v422 = {
    ["moneyreq"] = 5000,
    ["stamreq"] = 35,
    ["statreq"] = {
        ["FightingStyleMastery"] = 25,
        ["/SKILL/Vampire"] = 1
    },
    ["cd"] = 18,
    ["desc"] = "Leap forward and bite, replenishing health and blood."
}
v421["Vampire Bite"] = v422
local v423 = {
    ["moneyreq"] = 10000,
    ["stamreq"] = 15,
    ["statreq"] = {
        ["FightingStyleMastery"] = 35,
        ["/SKILL/Vampire"] = 2
    },
    ["cd"] = 7,
    ["desc"] = "Surround yourself in blood as you dash forward."
}
v421["Blood Dash"] = v423
local v424 = {
    ["moneyreq"] = 15000,
    ["stamreq"] = 25,
    ["statreq"] = {
        ["FightingStyleMastery"] = 55,
        ["/SKILL/Vampire"] = 3
    },
    ["cd"] = 25,
    ["desc"] = "Impale opponents with a chain of blood before pulling them back and striking them."
}
v421["Blood Chain"] = v424
local v425 = {
    ["transformation"] = true,
    ["moneyreq"] = 25000,
    ["stamreq"] = 45,
    ["statreq"] = {
        ["FightingStyleMastery"] = 65,
        ["/SKILL/Vampire"] = 4
    },
    ["cd"] = 18,
    ["desc"] = "Gain lifesteal off abilities in exchange for Blood."
}
v421["Blood Aura"] = v425
local v426 = {
    ["InstantCast"] = true,
    ["moneyreq"] = 50000,
    ["ULT"] = true,
    ["stamreq"] = 100,
    ["statreq"] = {
        ["FightingStyleMastery"] = 125,
        ["/SKILL/Vampire"] = 5
    },
    ["cd"] = 65,
    ["desc"] = "Summon dragons conjured from Blood that swarm and destroy the targetted area."
}
v421["Blood Dragon"] = v426
local v427 = {}
local v428 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["SwordMastery"] = 25
    },
    ["cd"] = 17,
    ["desc"] = "Ready a strike and teleport forwards, leaving behind a trail of slashes."
}
v427["Ruthless Blade"] = v428
local v429 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["SwordMastery"] = 55
    },
    ["cd"] = 12,
    ["desc"] = "Charge a strike and propel it forwards as a projectile."
}
v427["Dragon Flash"] = v429
local v430 = {}
local v431 = {
    ["stamreq"] = 0,
    ["statreq"] = {
        ["SwordMastery"] = 0
    },
    ["cd"] = 0,
    ["desc"] = "Gain the ability to swiftly evade out of attacks."
}
v430.BasicEvasive = v431
local v432 = {}
local v433 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["SwordMastery"] = 25
    },
    ["cd"] = 16,
    ["desc"] = "Leap towards an opponent and land with a burst of Haki.",
    ["InstantCast"] = true
}
v432["Final Retort"] = v433
local v434 = {
    ["stamreq"] = 30,
    ["statreq"] = {
        ["SwordMastery"] = 50
    },
    ["cd"] = 20,
    ["desc"] = "Taunt your enemies with a hearty laugh, and punish them greatly if they strike you.",
    ["IsCounter"] = true
}
v432["Laughing Counter"] = v434
local v435 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["SwordMastery"] = 75
    },
    ["cd"] = 14,
    ["desc"] = "Imbue haki into the blade, and deliver a devastating strike."
}
v432.Overflow = v435
local v436 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["SwordMastery"] = 100
    },
    ["cd"] = 18,
    ["desc"] = "Coat the blade in a supreme tier of Haki, before launching a slash that flies through the air."
}
v432["Divine Departure"] = v436
local v437 = {}
local v438 = {
    ["transformation"] = true,
    ["stamreq"] = 20,
    ["statreq"] = {
        ["DevilFruitMastery"] = 15
    },
    ["cd"] = 0.25,
    ["desc"] = "Transform your body into a golden substance, gaining Damage Reduction."
}
v437["Buddha Transformation"] = v438
local v439 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["DevilFruitMastery"] = 25
    },
    ["cd"] = 12,
    ["desc"] = "Strike forward and release a shockwave of pressure."
}
v437["Palm Strike"] = v439
local v440 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["DevilFruitMastery"] = 35
    },
    ["cd"] = 10,
    ["desc"] = "Release a Palm Strike infused with divine energy."
}
v437["Heavenly Shockwave"] = v440
local v441 = {
    ["stamreq"] = 50,
    ["statreq"] = {
        ["DevilFruitMastery"] = 50
    },
    ["cd"] = 15,
    ["desc"] = "Leap into the air and fall down to crush any beneath you."
}
v437["Judgement Impact"] = v441
local v442 = {
    ["stamreq"] = 20,
    ["statreq"] = {
        ["DevilFruitMastery"] = 60
    },
    ["cd"] = 20,
    ["desc"] = "Leap towards a targetted area, and release a wave of divine energy on impact."
}
v437["Heaven-sent Impact Leap"] = v442
local v443 = {
    ["statreq"] = {
        ["DevilFruitMastery"] = 85
    },
    ["stamreq"] = 100,
    ["cd"] = 18,
    ["desc"] = "As an amplified version of its predecessor, this technique strikes faster than the eye can see."
}
v437["Heaven-sent Impact"] = v443
local v444 = {
    ["statreq"] = {
        ["DevilFruitMastery"] = 85
    },
    ["stamreq"] = 75,
    ["cd"] = 28,
    ["desc"] = "Surround your allies in divine energy, giving them temporary buffs."
}
v437.Enlightenment = v444
local v445 = {
    ["statreq"] = {
        ["DevilFruitMastery"] = 85
    },
    ["stamreq"] = 35,
    ["cd"] = 12,
    ["desc"] = "Bear hug an opponent before suplex slamming them into the ground."
}
v437["Spine Breaker"] = v445
local v446 = {
    ["statreq"] = {
        ["DevilFruitMastery"] = 85
    },
    ["stamreq"] = 55,
    ["cd"] = 24,
    ["desc"] = "Grab onto an opponent and crush them in your palm before slamming them into the ground."
}
v437["Heaven Fall"] = v446
local v447 = {
    ["statreq"] = {
        ["DevilFruitMastery"] = 85
    },
    ["ULT"] = true,
    ["stamreq"] = 125,
    ["cd"] = 89,
    ["desc"] = "Charge an ultimate divine blast that releases a devastating explosion."
}
v437["Divine Retribution"] = v447
local v448 = {}
local v449 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["SwordMastery"] = 35
    },
    ["cd"] = 13,
    ["desc"] = "Impale an opponent, raise them overhead, and slam them into the ground."
}
v448["Pitchfork Impale"] = v449
local v450 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["SwordMastery"] = 45
    },
    ["cd"] = 20,
    ["desc"] = "Unleash a dance of slashes in front of you."
}
v448["Pitchfork Dance"] = v450
local v451 = {}
local v452 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["GunMastery"] = 35
    },
    ["cd"] = 17,
    ["desc"] = "Unleash a powerful ranged burst of energy from your Right Gun."
}
v451["Right Gun"] = v452
local v453 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["GunMastery"] = 45
    },
    ["cd"] = 13,
    ["desc"] = "Summon Soul Wolves that hunt down and target nearby opponents."
}
v451["Soul Wolves"] = v453
local v454 = {
    ["transformation"] = true,
    ["stamreq"] = 125,
    ["statreq"] = {
        ["GunMastery"] = 125
    },
    ["cd"] = 75,
    ["desc"] = "Fire a continous onslaught of blasts in a wide arc to completely overwhelm your foes."
}
v451["Cero Metralleta"] = v454
local v455 = {}
local v456 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["SwordMastery"] = 35
    },
    ["cd"] = 15,
    ["desc"] = "Raise the Halberd overheard and deliver sweeping slashes in a wide area."
}
v455["Hollow Sweep"] = v456
local v457 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["SwordMastery"] = 55
    },
    ["cd"] = 20,
    ["desc"] = "Charge forward and Impale an enemy, traveling with them for a great distance, or into a wall."
}
v455["Hollow Impale"] = v457
local v458 = {}
local v459 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["SwordMastery"] = 25
    },
    ["cd"] = 17,
    ["desc"] = "A two stage attack that involves a horizontal sweep and a vertical slash."
}
v458["Spirit Pierce"] = v459
local v460 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["SwordMastery"] = 45
    },
    ["cd"] = 20,
    ["desc"] = "Plunge the blade into the ground, and unleash a barrage of Spirits to swarm the enemy."
}
v458["Ghost Barrage"] = v460
local v461 = {}
local v462 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["SwordMastery"] = 25
    },
    ["cd"] = 14,
    ["desc"] = "Finesse with the whip allows you to grab onto an opponent and slam them into the ground."
}
v461["Whip Slam"] = v462
local v463 = {
    ["stamreq"] = 30,
    ["statreq"] = {
        ["SwordMastery"] = 55
    },
    ["cd"] = 16,
    ["desc"] = "Rapidly swing the Whip in order to create a barrier that allows for a simultaneous offense and defense."
}
v461["Tempestuous Defence"] = v463
local v464 = {}
local v465 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["SwordMastery"] = 25
    },
    ["cd"] = 40,
    ["desc"] = "Ignite the Kessui in flames to enhance its attack potency."
}
v464["Kessui Ignite"] = v465
local v466 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["SwordMastery"] = 45
    },
    ["cd"] = 14,
    ["desc"] = "A swift barrage of stabs that finish with a sweeping slash."
}
v464["Kessui Barrage"] = v466
local v467 = {}
local v468 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["SwordMastery"] = 45
    },
    ["cd"] = 17,
    ["desc"] = "Imbue the chilling daggers with piercing cold. Repeated strikes will freeze the opponent."
}
v467["Hellheim\'s Storm"] = v468
local v469 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["SwordMastery"] = 65
    },
    ["cd"] = 21,
    ["desc"] = "Imbue the chilling daggers with piercing cold. Repeated strikes will freeze the opponent."
}
v467["Flames Of Frost"] = v469
__set_list(u5, 81, {v394, v401, v406, v415, v421, v427, v430, v432, v437, v448, v451, v455, v458, v461, v464, v467})
local v470 = {}
local v471 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["GunMastery"] = 25
    },
    ["cd"] = 5,
    ["desc"] = "Imbue the chilling daggers with piercing cold. Repeated strikes will freeze the opponent.",
    ["InstantCast"] = true
}
v470["Firework Rocket"] = v471
local v472 = {
    ["stamreq"] = 75,
    ["statreq"] = {
        ["GunMastery"] = 45
    },
    ["cd"] = 19,
    ["desc"] = "Imbue the chilling daggers with piercing cold. Repeated strikes will freeze the opponent.",
    ["InstantCast"] = true
}
v470["Skyhigh Firework Rocket"] = v472
local v473 = {}
local v474 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["SwordMastery"] = 35
    },
    ["cd"] = 15,
    ["desc"] = "Imbue the chilling daggers with piercing cold. Repeated strikes will freeze the opponent."
}
v473["Frost Flash"] = v474
local v475 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["SwordMastery"] = 55
    },
    ["cd"] = 19,
    ["desc"] = "Imbue the chilling daggers with piercing cold. Repeated strikes will freeze the opponent."
}
v473["Frostfall Cascade"] = v475
local v476 = {}
local v477 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["SwordMastery"] = 35
    },
    ["cd"] = 18,
    ["desc"] = "Deliver multiple slashes forward before sheathing the blade."
}
v476["Firework Parade"] = v477
local v478 = {
    ["stamreq"] = 55,
    ["statreq"] = {
        ["SwordMastery"] = 65
    },
    ["cd"] = 25,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode."
}
v476["Dashing Pyrotechnics"] = v478
local v479 = {}
local v480 = {
    ["moneyreq"] = 5000,
    ["stamreq"] = 35,
    ["statreq"] = {
        ["FightingStyleMastery"] = 50,
        ["/SKILL/Moonlit Electro"] = 0
    },
    ["cd"] = 13,
    ["desc"] = "Leap forward and bite, replenishing health and blood."
}
v479["Thunderous Roar"] = v480
local v481 = {
    ["InstantCast"] = true,
    ["moneyreq"] = 5000,
    ["stamreq"] = 55,
    ["statreq"] = {
        ["FightingStyleMastery"] = 75,
        ["/SKILL/Moonlit Electro"] = 0
    },
    ["cd"] = 15,
    ["desc"] = "Leap forward and bite, replenishing health and blood."
}
v479["Thunderous Whirlwind"] = v481
local v482 = {
    ["moneyreq"] = 5000,
    ["stamreq"] = 35,
    ["statreq"] = {
        ["FightingStyleMastery"] = 100,
        ["/SKILL/Moonlit Electro"] = 0
    },
    ["cd"] = 16,
    ["desc"] = "Leap forward and bite, replenishing health and blood."
}
v479["Thunderous Tackle"] = v482
local v483 = {
    ["InstantCast"] = true,
    ["moneyreq"] = 5000,
    ["stamreq"] = 65,
    ["statreq"] = {
        ["FightingStyleMastery"] = 125,
        ["/SKILL/Moonlit Electro"] = 0
    },
    ["cd"] = 25,
    ["desc"] = "Leap forward and bite, replenishing health and blood."
}
v479["Thunderous Drill"] = v483
local v484 = {
    ["moneyreq"] = 5000,
    ["stamreq"] = 35,
    ["statreq"] = {
        ["FightingStyleMastery"] = 145,
        ["/SKILL/Moonlit Electro"] = 0
    },
    ["cd"] = 18,
    ["desc"] = "Leap forward and bite, replenishing health and blood."
}
v479["Thunderous Bite"] = v484
local v485 = {
    ["moneyreq"] = 5000,
    ["ULT"] = true,
    ["stamreq"] = 125,
    ["statreq"] = {
        ["FightingStyleMastery"] = 150,
        ["/SKILL/Moonlit Electro"] = 0
    },
    ["cd"] = 100,
    ["desc"] = "Leap forward and bite, replenishing health and blood."
}
v479["Thunderous Blitz"] = v485
local v486 = {
    ["stamreq"] = 10,
    ["statreq"] = {
        ["DevilFruitMastery"] = 0
    },
    ["cd"] = 0.5,
    ["desc"] = "Passive: Dash replaced with teleport."
}
v479.SulongDash = v486
local v487 = {}
local v488 = {
    ["stamreq"] = 55,
    ["statreq"] = {
        ["SwordMastery"] = 35
    },
    ["cd"] = 15,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode."
}
v487["Flower Aroma"] = v488
local v489 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["SwordMastery"] = 65
    },
    ["cd"] = 25,
    ["desc"] = "Deliver multiple slashes forward before sheathing the blade."
}
v487["Absolute Seduction"] = v489
local v490 = {}
local v491 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 45,
    ["statreq"] = {
        ["FightingStyleMastery"] = 45,
        ["/SKILL/Abyssal Karate"] = 1
    },
    ["cd"] = 13,
    ["desc"] = "Deliver a crushing blow with drenched fists."
}
v490["Demon Brick Fist"] = v491
local v492 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 25,
    ["statreq"] = {
        ["FightingStyleMastery"] = 65,
        ["/SKILL/Abyssal Karate"] = 1
    },
    ["cd"] = 15,
    ["desc"] = "Deliver a crushing blow with drenched fists."
}
v490["Splitting Sea Fist"] = v492
local v493 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 25,
    ["statreq"] = {
        ["FightingStyleMastery"] = 75,
        ["/SKILL/Abyssal Karate"] = 1
    },
    ["cd"] = 19,
    ["desc"] = "Deliver a crushing blow with drenched fists.",
    ["InstantCast"] = true,
    ["Grounded"] = true
}
v490["Diving Tides"] = v493
local v494 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 25,
    ["statreq"] = {
        ["FightingStyleMastery"] = 90,
        ["/SKILL/Abyssal Karate"] = 1
    },
    ["cd"] = 12,
    ["desc"] = "Deliver a crushing blow with drenched fists.",
    ["InstantCast"] = true
}
v490["Surging Bermuda"] = v494
local v495 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 25,
    ["statreq"] = {
        ["FightingStyleMastery"] = 100,
        ["/SKILL/Abyssal Karate"] = 1
    },
    ["cd"] = 17,
    ["desc"] = "Deliver a crushing blow with drenched fists."
}
v490["Feeding Frenzy"] = v495
local v496 = {
    ["moneyreq"] = 0,
    ["ULT"] = true,
    ["stamreq"] = 125,
    ["statreq"] = {
        ["FightingStyleMastery"] = 130,
        ["/SKILL/Abyssal Karate"] = 1
    },
    ["cd"] = 90,
    ["desc"] = "Deliver a crushing blow with drenched fists.",
    ["InstantCast"] = true
}
v490["Leviathan Plunge"] = v496
local v497 = {
    ["transformation"] = true,
    ["moneyreq"] = 0,
    ["stamreq"] = 25,
    ["statreq"] = {
        ["FightingStyleMastery"] = 150,
        ["/SKILL/Abyssal Karate"] = 1
    },
    ["cd"] = 1,
    ["desc"] = "Deliver a crushing blow with drenched fists."
}
v490["Abyssal Awakening"] = v497
local v498 = {}
local v499 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 25,
    ["statreq"] = {
        ["FightingStyleMastery"] = 45
    },
    ["cd"] = 15,
    ["desc"] = "Deliver a crushing blow with drenched fists."
}
v498["Shigan Barrage"] = v499
local v500 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 45,
    ["statreq"] = {
        ["FightingStyleMastery"] = 65
    },
    ["cd"] = 20,
    ["desc"] = "Deliver a crushing blow with drenched fists."
}
v498["Absolute Tekkai"] = v500
local v501 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 45,
    ["statreq"] = {
        ["FightingStyleMastery"] = 100
    },
    ["cd"] = 18,
    ["desc"] = "Deliver a crushing blow with drenched fists.",
    ["InstantCast"] = true
}
v498["Instant Soru"] = v501
local v502 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 45,
    ["statreq"] = {
        ["FightingStyleMastery"] = 125
    },
    ["cd"] = 18,
    ["desc"] = "Deliver a crushing blow with drenched fists."
}
v498["True Rankakyu"] = v502
local v503 = {
    ["moneyreq"] = 0,
    ["stamreq"] = 45,
    ["statreq"] = {
        ["FightingStyleMastery"] = 145
    },
    ["cd"] = 20,
    ["desc"] = "Deliver a crushing blow with drenched fists.",
    ["IsCounter"] = true
}
v498["Counter Kick"] = v503
local v504 = {
    ["ULT"] = true,
    ["moneyreq"] = 0,
    ["stamreq"] = 125,
    ["statreq"] = {
        ["FightingStyleMastery"] = 150
    },
    ["cd"] = 120,
    ["desc"] = "Deliver a crushing blow with drenched fists."
}
v498["True Rokuogan"] = v504
local v505 = {
    ["hyperArmor"] = true,
    ["moneyreq"] = 0,
    ["stamreq"] = 15,
    ["statreq"] = {
        ["FightingStyleMastery"] = 45
    },
    ["cd"] = 0.5,
    ["desc"] = "Deliver a crushing blow with drenched fists."
}
v498.KamishikiSoru = v505
local v506 = {
    ["percentStamina"] = v4.percentStamina,
    ["baseStamina"] = v4.baseStamina,
    ["moneyreq"] = 1750,
    ["statreq"] = {
        ["FightingStyleMastery"] = 20,
        ["/SKILL/Rokushiki"] = 4
    },
    ["stamreq"] = 0,
    ["cd"] = 0.2,
    ["desc"] = "The Geppo allows the users to actually jump off the air itself, allowing them to stay in the air for much longer than usual"
}
v498.KamishikiGeppo = v506
local v507 = {}
local v508 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["SwordMastery"] = 75
    },
    ["cd"] = 16,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode."
}
v507["Thousand Slices"] = v508
local v509 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["SwordMastery"] = 95
    },
    ["cd"] = 13,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode.",
    ["IsCounter"] = true
}
v507["Nightfall Counter"] = v509
local v510 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["SwordMastery"] = 100
    },
    ["cd"] = 20,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode."
}
v507["Nightfall Rush"] = v510
local v511 = {
    ["stamreq"] = 75,
    ["statreq"] = {
        ["SwordMastery"] = 150
    },
    ["cd"] = 30,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode."
}
v507["World\'s Strongest Slash"] = v511
local v512 = {}
local v513 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["DevilFruitMastery"] = 25
    },
    ["cd"] = 18,
    ["desc"] = "scream"
}
v512["Sonic Screech"] = v513
local v514 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["DevilFruitMastery"] = 45
    },
    ["cd"] = 12,
    ["desc"] = "bow"
}
v512["Vermillion Bow"] = v514
local v515 = {
    ["stamreq"] = 0,
    ["statreq"] = {
        ["DevilFruitMastery"] = 55
    },
    ["cd"] = 15,
    ["desc"] = "fly",
    ["IsFlight"] = true
}
v512["Winged Flight"] = v515
local v516 = {
    ["transformation"] = true,
    ["stamreq"] = 0,
    ["statreq"] = {
        ["DevilFruitMastery"] = 75
    },
    ["cd"] = 1,
    ["desc"] = "transform"
}
v512["Pteranodon Transform"] = v516
local v517 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["DevilFruitMastery"] = 85
    },
    ["cd"] = 17,
    ["desc"] = "grab"
}
v512["Skyborne Slam"] = v517
local v518 = {
    ["stamreq"] = 50,
    ["statreq"] = {
        ["DevilFruitMastery"] = 100
    },
    ["cd"] = 30,
    ["desc"] = "form"
}
v512["Flame Form"] = v518
local v519 = {
    ["ULT"] = true,
    ["stamreq"] = 75,
    ["statreq"] = {
        ["DevilFruitMastery"] = 125
    },
    ["cd"] = 25,
    ["desc"] = "strikes"
}
v512["Relentless Strikes"] = v519
local v520 = {
    ["stamreq"] = 20,
    ["statreq"] = {
        ["DevilFruitMastery"] = 0
    },
    ["cd"] = 9,
    ["desc"] = "roll"
}
v512["Barrel Roll"] = v520
local v521 = {
    ["stamreq"] = 20,
    ["statreq"] = {
        ["DevilFruitMastery"] = 125
    },
    ["cd"] = 1,
    ["desc"] = "roll"
}
v512["Pteranodon Carry"] = v521
local v522 = {
    ["stamreq"] = 55,
    ["statreq"] = {
        ["DevilFruitMastery"] = 135
    },
    ["cd"] = 25,
    ["desc"] = "storm"
}
v512["Imperial Storm"] = v522
local v523 = {
    ["ULT"] = true,
    ["stamreq"] = 75,
    ["statreq"] = {
        ["DevilFruitMastery"] = 175
    },
    ["cd"] = 125,
    ["desc"] = "dive"
}
v512["Imperial Dive Bomb"] = v523
local v524 = {}
local v525 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["SwordMastery"] = 25
    },
    ["cd"] = 13,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode.",
    ["IsCounter"] = true
}
v524["Massacre Counter"] = v525
local v526 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["SwordMastery"] = 65
    },
    ["cd"] = 16,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode."
}
v524["Chain Reel"] = v526
local v527 = {}
local v528 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["DevilFruitMastery"] = 50
    },
    ["cd"] = 15,
    ["desc"] = "Discharge a burst of light that explodes on impact."
}
v527["Starlight Rapier: Blitzstrike"] = v528
local v529 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["DevilFruitMastery"] = 75
    },
    ["cd"] = 13,
    ["desc"] = "Discharge a burst of light that explodes on impact."
}
v527["Radiant Kick"] = v529
local v530 = {
    ["stamreq"] = 65,
    ["statreq"] = {
        ["DevilFruitMastery"] = 85
    },
    ["cd"] = 18,
    ["desc"] = "Discharge a burst of light that explodes on impact."
}
v527["Radiant Ray"] = v530
local v531 = {
    ["stamreq"] = 15,
    ["statreq"] = {
        ["DevilFruitMastery"] = 90
    },
    ["cd"] = 15,
    ["desc"] = "Discharge a burst of light that explodes on impact.",
    ["IsFlight"] = true
}
v527["Radiant Flight"] = v531
local v532 = {
    ["stamreq"] = 75,
    ["statreq"] = {
        ["DevilFruitMastery"] = 120
    },
    ["cd"] = 30,
    ["desc"] = "Discharge a burst of light that explodes on impact."
}
v527["Radiant Jewels"] = v532
local v533 = {
    ["stamreq"] = 100,
    ["statreq"] = {
        ["DevilFruitMastery"] = 150
    },
    ["ULT"] = true,
    ["cd"] = 70,
    ["desc"] = "Discharge a burst of light that explodes on impact."
}
v527["Starlight Rapier: Excalibur"] = v533
local v534 = {
    ["stamreq"] = 10,
    ["statreq"] = {
        ["DevilFruitMastery"] = 0
    },
    ["cd"] = 0.5,
    ["desc"] = "Passive: Dash replaced with teleport."
}
v527.PikaDashV2 = v534
local v535 = {}
local v536 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["DevilFruitMastery"] = 25
    },
    ["cd"] = 10,
    ["desc"] = "Discharge a burst of light that explodes on impact."
}
v535["Golden Fist"] = v536
local v537 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["DevilFruitMastery"] = 50
    },
    ["cd"] = 15,
    ["desc"] = "Discharge a burst of light that explodes on impact."
}
v535["Golden Touch"] = v537
local v538 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["DevilFruitMastery"] = 75
    },
    ["cd"] = 25,
    ["desc"] = "Discharge a burst of light that explodes on impact."
}
v535["Golden Path"] = v538
local v539 = {
    ["stamreq"] = 50,
    ["statreq"] = {
        ["DevilFruitMastery"] = 90
    },
    ["cd"] = 15,
    ["desc"] = "Discharge a burst of light that explodes on impact."
}
v535["Golden Field"] = v539
local v540 = {
    ["stamreq"] = 55,
    ["statreq"] = {
        ["DevilFruitMastery"] = 100
    },
    ["cd"] = 23,
    ["desc"] = "Discharge a burst of light that explodes on impact."
}
v535["Golden Judgement"] = v540
local v541 = {
    ["stamreq"] = 100,
    ["statreq"] = {
        ["DevilFruitMastery"] = 125
    },
    ["cd"] = 120,
    ["desc"] = "Discharge a burst of light that explodes on impact.",
    ["ULT"] = true
}
v535["Golden Age"] = v541
local v542 = {}
local v543 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["Strength"] = 25
    },
    ["cd"] = 13,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode."
}
v542["Sunken Depths"] = v543
local v544 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["Strength"] = 65
    },
    ["cd"] = 16,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode."
}
v542["Sunken Hook"] = v544
local v545 = {}
local v546 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["FightingStyleMastery"] = 45
    },
    ["cd"] = 14,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode."
}
v545["Oversized Iron Ball"] = v546
local v547 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["FightingStyleMastery"] = 65
    },
    ["cd"] = 17,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode."
}
v545["Meteor Fist Shower"] = v547
local v548 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["FightingStyleMastery"] = 75
    },
    ["cd"] = 16,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode."
}
v545["Fusillade Fist"] = v548
local v549 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["FightingStyleMastery"] = 125
    },
    ["cd"] = 20,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode."
}
v545["Fist Of Love"] = v549
local v550 = {
    ["stamreq"] = 200,
    ["statreq"] = {
        ["FightingStyleMastery"] = 175
    },
    ["cd"] = 120,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode.",
    ["ULT"] = true
}
v545["Galaxy Impact"] = v550
local v551 = {}
local v552 = {
    ["stamreq"] = 30,
    ["statreq"] = {
        ["DevilFruitMastery"] = 25
    },
    ["cd"] = 15,
    ["desc"] = "Discharge a burst of light that explodes on impact."
}
v551["White Barrage"] = v552
local v553 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["DevilFruitMastery"] = 40
    },
    ["cd"] = 25,
    ["desc"] = "Discharge a burst of light that explodes on impact."
}
v551["White Out"] = v553
local v554 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["DevilFruitMastery"] = 75
    },
    ["cd"] = 15,
    ["desc"] = "Discharge a burst of light that explodes on impact.",
    ["IsFlight"] = true
}
v551["White Rocket"] = v554
local v555 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["DevilFruitMastery"] = 90
    },
    ["cd"] = 20,
    ["desc"] = "Discharge a burst of light that explodes on impact."
}
v551["White Snake"] = v555
local v556 = {
    ["stamreq"] = 85,
    ["statreq"] = {
        ["DevilFruitMastery"] = 125
    },
    ["cd"] = 75,
    ["desc"] = "Discharge a burst of light that explodes on impact.",
    ["ULT"] = true
}
v551["White Fog"] = v556
local v557 = {}
local v558 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["Strength"] = 45
    },
    ["cd"] = 13,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode."
}
v557["Jitte Strike"] = v558
local v559 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["Strength"] = 65
    },
    ["cd"] = 16,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode."
}
v557["Jitte Leap"] = v559
__set_list(u5, 97, {v470, v473, v476, v479, v487, v490, v498, v507, v512, v524, v527, v535, v542, v545, v551, v557})
local v560 = {}
local v561 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["SwordMastery"] = 25
    },
    ["cd"] = 13,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode."
}
v560["Reaping Strike"] = v561
local v562 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["SwordMastery"] = 65
    },
    ["cd"] = 16,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode."
}
v560["Reaping Grasp"] = v562
local v563 = {}
local v564 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["SwordMastery"] = 25
    },
    ["cd"] = 13,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode."
}
v563["Victory Maul"] = v564
local v565 = {}
local v566 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["SwordMastery"] = 25
    },
    ["isFS"] = true,
    ["cd"] = 13,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode."
}
v565["1080 Pound Phoenix"] = v566
local v567 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["SwordMastery"] = 45
    },
    ["isFS"] = true,
    ["cd"] = 13,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode."
}
v565.Onigiri = v567
local v568 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["SwordMastery"] = 55
    },
    ["isFS"] = true,
    ["cd"] = 15,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode."
}
v565["Dragon Twister"] = v568
local v569 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["SwordMastery"] = 75
    },
    ["isFS"] = true,
    ["cd"] = 13,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode."
}
v565["Tiger Hunt"] = v569
local v570 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["SwordMastery"] = 85
    },
    ["isFS"] = true,
    ["cd"] = 20,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode."
}
v565["Crossing Six Paths"] = v570
local v571 = {
    ["stamreq"] = 115,
    ["ULT"] = true,
    ["statreq"] = {
        ["SwordMastery"] = 150
    },
    ["isFS"] = true,
    ["cd"] = 90,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode."
}
v565["Billion-Fold World"] = v571
local v572 = {
    ["stamreq"] = 0,
    ["statreq"] = {
        ["FightingStyle"] = "3SS",
        ["SwordMastery"] = 250
    },
    ["isFS"] = true,
    ["cd"] = 0.3,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode."
}
v565["Sword Style Swap"] = v572
local v573 = {}
local v574 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["DevilFruitMastery"] = 30
    },
    ["cd"] = 16,
    ["desc"] = "Transform into a mochi doughnut to bulldoze your victims."
}
v573["Mochi Blitz Barrage"] = v574
local v575 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["DevilFruitMastery"] = 65
    },
    ["cd"] = 20,
    ["desc"] = "Project a gigantic mochi fist clad in haki."
}
v573["Burning Power Mochi"] = v575
local v576 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["DevilFruitMastery"] = 75
    },
    ["cd"] = 22,
    ["desc"] = "Project a gigantic mochi fist clad in haki.",
    ["Grounded"] = true
}
v573["Zigzag Power Pummel"] = v576
local v577 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["DevilFruitMastery"] = 85
    },
    ["cd"] = 18,
    ["desc"] = "Transform into a mochi doughnut to bulldoze your victims."
}
v573["Spiked Donut Roll"] = v577
local v578 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["DevilFruitMastery"] = 95
    },
    ["cd"] = 30,
    ["desc"] = "Transform into a mochi doughnut to bulldoze your victims."
}
v573["Burning Chestnut Mochi"] = v578
local v579 = {
    ["stamreq"] = 50,
    ["statreq"] = {
        ["DevilFruitMastery"] = 125
    },
    ["cd"] = 25,
    ["desc"] = "Transform into a mochi doughnut to bulldoze your victims."
}
v573["Burning Mochi Rocket"] = v579
local v580 = {
    ["stamreq"] = 100,
    ["statreq"] = {
        ["DevilFruitMastery"] = 150
    },
    ["ULT"] = true,
    ["cd"] = 125,
    ["desc"] = "Transform into a mochi doughnut to bulldoze your victims.",
    ["hyperArmor"] = true
}
v573["Supreme Mochi Buzzcut"] = v580
local v581 = {}
local v582 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["GunMastery"] = 25
    },
    ["cd"] = 13,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode."
}
v581.IceGunbladePull = v582
local v583 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["GunMastery"] = 25
    },
    ["cd"] = 12,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode."
}
v581["Frost Bullets"] = v583
local v584 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["GunMastery"] = 55
    },
    ["cd"] = 17,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode."
}
v581["Frost Blast"] = v584
local v585 = {}
local v586 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["SwordMastery"] = 25
    },
    ["cd"] = 2,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode."
}
v585["Scepter Snowball"] = v586
local v587 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["SwordMastery"] = 25
    },
    ["cd"] = 17,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode."
}
v585["Scepter Storm"] = v587
local v588 = {}
local v589 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["DevilFruitMastery"] = 35
    },
    ["cd"] = 15,
    ["desc"] = ""
}
v588["Diamond Dash"] = v589
local v590 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["DevilFruitMastery"] = 45
    },
    ["cd"] = 10,
    ["desc"] = ""
}
v588["Diamond Kick"] = v590
local v591 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["DevilFruitMastery"] = 55
    },
    ["cd"] = 12,
    ["desc"] = "",
    ["Grounded"] = true
}
v588["Rock Toss"] = v591
local v592 = {
    ["stamreq"] = 0,
    ["statreq"] = {
        ["DevilFruitMastery"] = 75
    },
    ["cd"] = 10,
    ["desc"] = ""
}
v588["Diamond Defense"] = v592
local v593 = {
    ["stamreq"] = 125,
    ["statreq"] = {
        ["DevilFruitMastery"] = 100
    },
    ["cd"] = 85,
    ["desc"] = "",
    ["Grounded"] = true,
    ["ULT"] = true
}
v588["Prismatic Lift"] = v593
local v594 = {}
local v595 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["GunMastery"] = 25
    },
    ["cd"] = 14,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode."
}
v594["Cupid\'s Rain"] = v595
local v596 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["GunMastery"] = 55
    },
    ["cd"] = 17,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode."
}
v594["Cupid Burst"] = v596
local v597 = {}
local v598 = {
    ["stamreq"] = 0,
    ["statreq"] = {
        ["GunMastery"] = 0
    },
    ["cd"] = 5,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode.",
    ["hideMobile"] = true
}
v597["Rapid Fire"] = v598
local v599 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["GunMastery"] = 55
    },
    ["cd"] = 17,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode."
}
v597["Monkey Chompers"] = v599
local v600 = {
    ["stamreq"] = 75,
    ["statreq"] = {
        ["GunMastery"] = 100
    },
    ["cd"] = 40,
    ["desc"] = "Fire an ultra-accurate, explosive projectile that scales with charge. The resulting blast is nigh unstoppable."
}
v597["SUPER MEGA DEATH ROCKET!"] = v600
local v601 = {}
local v602 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["Strength"] = 25
    },
    ["cd"] = 14,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode.",
    ["Grounded"] = true
}
v601["Eggsplosive Rift"] = v602
local v603 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["Strength"] = 55
    },
    ["cd"] = 17,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode."
}
v601.Eggsweeper = v603
local v604 = {}
local v605 = {
    ["hyperArmor"] = true,
    ["stamreq"] = 45,
    ["statreq"] = {
        ["SwordMastery"] = 45
    },
    ["cd"] = 15,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode."
}
v604["Aquatic Lunge"] = v605
local v606 = {
    ["stamreq"] = 55,
    ["statreq"] = {
        ["SwordMastery"] = 75
    },
    ["cd"] = 20,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode."
}
v604["Call of the Deep"] = v606
local v607 = {}
local v608 = {
    ["stamreq"] = 15,
    ["statreq"] = {
        ["DevilFruitMastery"] = 25
    },
    ["cd"] = 12,
    ["desc"] = ""
}
v607["Hellfire Ring"] = v608
local v609 = {
    ["stamreq"] = 30,
    ["statreq"] = {
        ["DevilFruitMastery"] = 30
    },
    ["cd"] = 18,
    ["desc"] = ""
}
v607["Draconic Warcry"] = v609
local v610 = {
    ["stamreq"] = 0,
    ["statreq"] = {
        ["DevilFruitMastery"] = 55
    },
    ["cd"] = 3,
    ["desc"] = "",
    ["transformation"] = true
}
v607["Draconic Ascension"] = v610
local v611 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["DevilFruitMastery"] = 65
    },
    ["cd"] = 20,
    ["desc"] = ""
}
v607["Thunderclad Veil"] = v611
local v612 = {
    ["stamreq"] = 55,
    ["statreq"] = {
        ["DevilFruitMastery"] = 80
    },
    ["cd"] = 17,
    ["desc"] = ""
}
v607["Draconic Cataclysm"] = v612
local v613 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["DevilFruitMastery"] = 70
    },
    ["cd"] = 16,
    ["desc"] = ""
}
v607["Draconic Tail Slam"] = v613
local v614 = {
    ["stamreq"] = 30,
    ["statreq"] = {
        ["DevilFruitMastery"] = 75
    },
    ["cd"] = 20,
    ["desc"] = ""
}
v607["Draconic Thunderfall"] = v614
local v615 = {
    ["stamreq"] = 60,
    ["statreq"] = {
        ["DevilFruitMastery"] = 85
    },
    ["cd"] = 18,
    ["desc"] = ""
}
v607["Thunderclaw Rush"] = v615
local v616 = {
    ["stamreq"] = 80,
    ["statreq"] = {
        ["DevilFruitMastery"] = 95
    },
    ["cd"] = 30,
    ["desc"] = ""
}
v607["Hellfire Ray"] = v616
local v617 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["DevilFruitMastery"] = 100
    },
    ["cd"] = 8,
    ["desc"] = "",
    ["hideMobile"] = true
}
v607["Draconic Breath"] = v617
local v618 = {
    ["stamreq"] = 40,
    ["statreq"] = {
        ["DevilFruitMastery"] = 100
    },
    ["cd"] = 40,
    ["desc"] = ""
}
v607["Hellfire Mode"] = v618
local v619 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["DevilFruitMastery"] = 110
    },
    ["cd"] = 26,
    ["desc"] = ""
}
v607["Draconic Thundercry"] = v619
local v620 = {
    ["stamreq"] = 60,
    ["statreq"] = {
        ["DevilFruitMastery"] = 125
    },
    ["cd"] = 22,
    ["desc"] = ""
}
v607["Draconic Cyclone"] = v620
local v621 = {
    ["stamreq"] = 60,
    ["statreq"] = {
        ["DevilFruitMastery"] = 135
    },
    ["cd"] = 25,
    ["desc"] = ""
}
v607["Draconic Tempest Spiral"] = v621
local v622 = {
    ["stamreq"] = 100,
    ["statreq"] = {
        ["DevilFruitMastery"] = 155
    },
    ["cd"] = 90,
    ["desc"] = ""
}
v607["Hellfire Blast Breath"] = v622
local v623 = {}
local v624 = {
    ["stamreq"] = 0,
    ["statreq"] = {
        ["DevilFruitMastery"] = 0
    },
    ["cd"] = 0.1,
    ["desc"] = ""
}
v623["Soul Swap"] = v624
local v625 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["DevilFruitMastery"] = 35
    },
    ["cd"] = 13,
    ["desc"] = ""
}
v623["Thunder Drop"] = v625
local v629 = {
    ["stamreq"] = 15,
    ["statreq"] = {
        ["DevilFruitMastery"] = 55
    },
    ["cd"] = 0.2,
    ["percentStamina"] = 0.03,
    ["baseStamina"] = 5,
    ["customCDInfo"] = {
        ["FullCooldown"] = 15,
        ["FunctionCheck"] = function(p626, p627) --[[ Name: FunctionCheck, Line 991 ]]
            --[[
            Upvalues:
                [1] = u2
            --]]
            local v628 = p627:GetAttribute("StormCircuitCount")
            if v628 then
                if v628 >= 5 then
                    if p626 and u2 == true then
                        return false
                    else
                        return false
                    end
                else
                    return
                end
            else
                return true
            end
        end
    },
    ["desc"] = ""
}
v623["Storm Circuit"] = v629
local v630 = {
    ["stamreq"] = 15,
    ["statreq"] = {
        ["DevilFruitMastery"] = 65
    },
    ["cd"] = 20,
    ["desc"] = "",
    ["IsFlight"] = true
}
v623["Nimbus Ride"] = v630
local v631 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["DevilFruitMastery"] = 75
    },
    ["cd"] = 20,
    ["desc"] = ""
}
v623["Storm Chaser"] = v631
local v632 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["DevilFruitMastery"] = 85
    },
    ["cd"] = 18,
    ["desc"] = ""
}
v623["Raijin Plunge"] = v632
local v633 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["DevilFruitMastery"] = 95
    },
    ["cd"] = 20,
    ["desc"] = ""
}
v623["Zigzag Bolt"] = v633
local v634 = {
    ["stamreq"] = 75,
    ["statreq"] = {
        ["DevilFruitMastery"] = 150
    },
    ["cd"] = 75,
    ["desc"] = "",
    ["hyperArmor"] = true
}
v623["Divine Thunderfall"] = v634
local v635 = {
    ["stamreq"] = 15,
    ["statreq"] = {
        ["DevilFruitMastery"] = 35
    },
    ["cd"] = 3,
    ["desc"] = ""
}
v623["Bon-Bon Fireball"] = v635
local v636 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["DevilFruitMastery"] = 55
    },
    ["cd"] = 12,
    ["desc"] = ""
}
v623["Bon-Bon Bomb"] = v636
local v637 = {
    ["stamreq"] = 55,
    ["statreq"] = {
        ["DevilFruitMastery"] = 75
    },
    ["cd"] = 20,
    ["desc"] = ""
}
v623["Prominence Ray"] = v637
local v638 = {
    ["stamreq"] = 45,
    ["statreq"] = {
        ["DevilFruitMastery"] = 85
    },
    ["cd"] = 20,
    ["desc"] = ""
}
v623["Prominence Punch"] = v638
local v639 = {
    ["stamreq"] = 55,
    ["statreq"] = {
        ["DevilFruitMastery"] = 100
    },
    ["cd"] = 25,
    ["desc"] = ""
}
v623["Bon-Bon Torch"] = v639
local v640 = {
    ["stamreq"] = 75,
    ["statreq"] = {
        ["DevilFruitMastery"] = 150
    },
    ["cd"] = 90,
    ["desc"] = "",
    ["hyperArmor"] = true
}
v623["Sunfall Cataclysm"] = v640
local v641 = {
    ["stamreq"] = 0,
    ["statreq"] = {
        ["DevilFruitMastery"] = 25
    },
    ["cd"] = 2,
    ["desc"] = ""
}
v623["Lick, the Lollipop"] = v641
local v642 = {
    ["stamreq"] = 0,
    ["statreq"] = {
        ["DevilFruitMastery"] = 35
    },
    ["cd"] = 2,
    ["desc"] = ""
}
v623["Crumbleshot, the Cake"] = v642
local v643 = {
    ["stamreq"] = 0,
    ["statreq"] = {
        ["DevilFruitMastery"] = 55
    },
    ["cd"] = 2,
    ["desc"] = ""
}
v623["Gloomroot, the Tree"] = v643
local v644 = {
    ["stamreq"] = 0,
    ["statreq"] = {
        ["DevilFruitMastery"] = 85
    },
    ["cd"] = 1,
    ["desc"] = "",
    ["transformation"] = true
}
v623["Soul Rage"] = v644
local v645 = {
    ["stamreq"] = 0,
    ["statreq"] = {
        ["DevilFruitMastery"] = 25
    },
    ["cd"] = 0.1,
    ["desc"] = ""
}
v623["Soul Summoning"] = v645
local v646 = {}
local v647 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["SwordMastery"] = 25
    },
    ["cd"] = 15,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode."
}
v646["Umbrella Float"] = v647
local v648 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["SwordMastery"] = 55
    },
    ["cd"] = 13,
    ["desc"] = "Propel yourself forward and unleash a trail of bombs that explode."
}
v646["Umbrella Thrust"] = v648
local v649 = {}
local v650 = {
    ["stamreq"] = 0,
    ["statreq"] = {
        ["SwordMastery"] = 35
    },
    ["cd"] = 20,
    ["desc"] = "Release 3 energy slashes"
}
v649["THE TROXX2"] = v650
local v651 = {
    ["stamreq"] = 0,
    ["statreq"] = {
        ["SwordMastery"] = 75
    },
    ["cd"] = 30,
    ["desc"] = "Impale a target and drain their life, healing yourself for a portion."
}
v649["Soul Eater2"] = v651
local v652 = {}
local v653 = {
    ["stamreq"] = 30,
    ["statreq"] = {
        ["SwordMastery"] = 45
    },
    ["cd"] = 13,
    ["desc"] = ""
}
v652["Wringing Vortex"] = v653
local v654 = {
    ["stamreq"] = 50,
    ["statreq"] = {
        ["SwordMastery"] = 75
    },
    ["cd"] = 16,
    ["desc"] = ""
}
v652["Wringing Rupture"] = v654
__set_list(u5, 113, {v560, v563, v565, v573, v581, v585, v588, v594, v597, v601, v604, v607, v623, v646, v649, v652})
local v655 = {}
local v656 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["SwordMastery"] = 35
    },
    ["cd"] = 14,
    ["desc"] = ""
}
v655["Maser Ray"] = v656
local v657 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["SwordMastery"] = 75
    },
    ["cd"] = 16,
    ["desc"] = ""
}
v655.Hahaba = v657
local v658 = {
    ["stamreq"] = 50,
    ["statreq"] = {
        ["SwordMastery"] = 100,
        ["DF"] = "Soul-Soul"
    },
    ["cd"] = 17,
    ["desc"] = ""
}
v655["Hakai Slash"] = v658
local v659 = {
    ["stamreq"] = 55,
    ["statreq"] = {
        ["SwordMastery"] = 125,
        ["DF"] = "Soul-Soul"
    },
    ["cd"] = 25,
    ["desc"] = "",
    ["Grounded"] = true
}
v655["Blaze Eruption"] = v659
local v660 = {}
local v661 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["SwordMastery"] = 35
    },
    ["cd"] = 13,
    ["desc"] = ""
}
v660["Mochi Trident Drill"] = v661
local v662 = {
    ["stamreq"] = 55,
    ["statreq"] = {
        ["SwordMastery"] = 65
    },
    ["cd"] = 19,
    ["desc"] = ""
}
v660["Mochi Trident Throw"] = v662
local v663 = {}
local v664 = {
    ["stamreq"] = 30,
    ["statreq"] = {
        ["SwordMastery"] = 45
    },
    ["cd"] = 13,
    ["desc"] = ""
}
v663["Pretzel Stabs"] = v664
local v665 = {
    ["stamreq"] = 50,
    ["statreq"] = {
        ["SwordMastery"] = 75
    },
    ["cd"] = 16,
    ["desc"] = ""
}
v663["Pretzel Blitz Strikes"] = v665
local v666 = {}
local v667 = {
    ["stamreq"] = 15,
    ["statreq"] = {
        ["DevilFruitMastery"] = 25
    },
    ["cd"] = 10,
    ["desc"] = ""
}
v666["Shigan: Fire Bullet"] = v667
local v668 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["DevilFruitMastery"] = 35
    },
    ["cd"] = 14,
    ["desc"] = ""
}
v666["Shigan: Renzoku"] = v668
local v669 = {
    ["stamreq"] = 0,
    ["statreq"] = {
        ["DevilFruitMastery"] = 55
    },
    ["cd"] = 3,
    ["desc"] = "",
    ["transformation"] = true
}
v666["Leopard Ascension"] = v669
local v670 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["DevilFruitMastery"] = 65
    },
    ["cd"] = 20,
    ["desc"] = ""
}
v666["Predator\'s Intimidation"] = v670
local v671 = {
    ["stamreq"] = 30,
    ["statreq"] = {
        ["DevilFruitMastery"] = 70
    },
    ["cd"] = 12,
    ["desc"] = ""
}
v666["Predator Speed Blitz"] = v671
local v672 = {
    ["stamreq"] = 0,
    ["statreq"] = {
        ["DevilFruitMastery"] = 80
    },
    ["cd"] = 16,
    ["desc"] = ""
}
v666["Rankyaku: Rebound"] = v672
local v673 = {
    ["stamreq"] = 0,
    ["statreq"] = {
        ["DevilFruitMastery"] = 90
    },
    ["cd"] = 25,
    ["desc"] = ""
}
v666["Sai Dai Rin: Hyou Rokuogan"] = v673
local v674 = {
    ["stamreq"] = 70,
    ["statreq"] = {
        ["DevilFruitMastery"] = 95
    },
    ["cd"] = 30,
    ["desc"] = ""
}
v666["Sai Dai Rin: Apex Execution"] = v674
local v675 = {}
local v676 = {
    ["stamreq"] = 30,
    ["statreq"] = {
        ["SwordMastery"] = 35
    },
    ["cd"] = 13,
    ["desc"] = ""
}
v675["Dimensional Slash"] = v676
local v677 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["SwordMastery"] = 90
    },
    ["cd"] = 20,
    ["desc"] = ""
}
v675["Divine Fury"] = v677
local v678 = {}
local v679 = {
    ["stamreq"] = 0,
    ["statreq"] = {
        ["SwordMastery"] = 0
    },
    ["cd"] = 13,
    ["desc"] = ""
}
v678["Cracker Tackle"] = v679
local v680 = {
    ["stamreq"] = 0,
    ["statreq"] = {
        ["SwordMastery"] = 0
    },
    ["cd"] = 13,
    ["desc"] = ""
}
v678["Cookie Crusher"] = v680
local v681 = {
    ["stamreq"] = 0,
    ["statreq"] = {
        ["SwordMastery"] = 0
    },
    ["cd"] = 13,
    ["desc"] = ""
}
v678["Biscuit Slider"] = v681
local v682 = {
    ["stamreq"] = 0,
    ["statreq"] = {
        ["SwordMastery"] = 0
    },
    ["cd"] = 13,
    ["desc"] = ""
}
v678["Graham Slam"] = v682
local v683 = {
    ["stamreq"] = 0,
    ["statreq"] = {
        ["SwordMastery"] = 0
    },
    ["cd"] = 13,
    ["desc"] = ""
}
v678["Biscuit Barricade"] = v683
local v684 = {
    ["stamreq"] = 0,
    ["statreq"] = {
        ["SwordMastery"] = 0
    },
    ["cd"] = 13,
    ["desc"] = ""
}
v678["Cookie Commander"] = v684
local v685 = {}
local v686 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["SwordMastery"] = 25
    },
    ["cd"] = 14,
    ["desc"] = ""
}
v685["Enchanting Grasp"] = v686
local v687 = {
    ["stamreq"] = 35,
    ["statreq"] = {
        ["SwordMastery"] = 55
    },
    ["cd"] = 16,
    ["desc"] = ""
}
v685["Cupid\'s Embrace"] = v687
local v688 = {}
local v689 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["SwordMastery"] = 25
    },
    ["cd"] = 14,
    ["desc"] = ""
}
v688.Molinelli = v689
local v690 = {
    ["stamreq"] = 25,
    ["statreq"] = {
        ["SwordMastery"] = 25
    },
    ["cd"] = 14,
    ["desc"] = ""
}
v688["Beast Sword"] = v690
__set_list(u5, 129, {v655, v660, v663, v666, v675, v678, v685, v688})
v1.Skills = u5
function v1.Get(p691) --[[ Line: 1124 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    if p691 == "Black Leg" then
        return u5[1]
    end
    if p691 == "Rokushiki" then
        return u5[2]
    end
    if p691 == "Ice" then
        return u5[5]
    end
    if p691 == "Gomu" then
        return u5[6]
    end
    if p691 == "Buddha" then
        return u5[7]
    end
    if p691 == "1SS" then
        return u5[8]
    end
end
function v1.GetM(p692) --[[ Line: 1140 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    for v693 = 1, #u5 do
        for v694, v695 in u5[v693] do
            if v694 == p692 then
                return v695
            end
        end
    end
end
repeat
    game["Run Service"].Heartbeat:Wait()
until game.ReplicatedStorage.reservedCode.Value ~= "checking"
table.clone(u5)
for v696 = 1, #u5 do
    for _, v697 in u5[v696] do
        if v697.NormalCD == nil then
            v697.NormalCD = v697.cd
        else
            warn("already has a normal cd!@")
        end
    end
end
if game.GameId == 2097989947 then
    for v698 = 1, #u5 do
        for _, v699 in u5[v698] do
            v699.cd = 0.1
        end
    end
end
local function u703(u700) --[[ Line: 1181 ]]
    local u701 = game.Players:GetPlayers()
    for u702 = 1, #u701 do
        task.spawn(function() --[[ Line: 1184 ]]
            --[[
            Upvalues:
                [1] = u701
                [2] = u702
                [3] = u700
            --]]
            script.getCDs:InvokeClient(u701[u702], u700)
        end)
    end
end
script.normalSkillMult.Changed:Connect(function() --[[ Line: 1192 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u5
        [3] = u703
    --]]
    if u2 then
        warn("updating cooldowns normal")
        local v704 = {}
        for v705 = 1, #u5 do
            for v706, v707 in u5[v705] do
                if v707.ULT == nil and v707.NormalCD ~= nil then
                    local v708 = v707.NormalCD * script.normalSkillMult.Value
                    local v709 = math.clamp(v708, 0.5, 100000000000)
                    v707.cd = v709
                    v704[#v704 + 1] = { v705, v706, v709 }
                end
            end
        end
        u703(v704)
    end
end)
script.ultSkillMult.Changed:Connect(function() --[[ Line: 1215 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u5
        [3] = u703
    --]]
    if u2 then
        warn("updating cooldowns ult")
        local v710 = {}
        for v711 = 1, #u5 do
            for v712, v713 in u5[v711] do
                if v713.ULT ~= nil and (v713.cd ~= nil and v713.NormalCD ~= nil) then
                    local v714 = v713.NormalCD * script.ultSkillMult.Value
                    local v715 = math.clamp(v714, 0.5, 100000000000)
                    v713.cd = v715
                    v710[#v710 + 1] = { v711, v712, v715 }
                end
            end
        end
        u703(v710)
    end
end)
function v1.arenaCDs(_) --[[ Line: 1238 ]]
    script.normalSkillMult.Value = 1.5
    script.ultSkillMult.Value = 3
end
function v1.normalCDs(_) --[[ Line: 1243 ]]
    script.normalSkillMult.Value = 1
    script.ultSkillMult.Value = 1
end
function v1.noCDs(_) --[[ Line: 1248 ]]
    script.normalSkillMult.Value = 0.0001
    script.ultSkillMult.Value = 0.0001
end
if u2 and (game.ReplicatedStorage.reservedCode.Value == "arena" and (_G.conquest == nil and (_G.ImpelDown == nil and v3:IsStudio() == false))) then
    v1:arenaCDs()
end
if u2 then
    function script.getCDs.OnServerInvoke() --[[ Line: 1258 ]]
        --[[
        Upvalues:
            [1] = u5
        --]]
        local v716 = {}
        for v717 = 1, #u5 do
            v716[v717] = {}
            for v718, v719 in u5[v717] do
                v716[v717][v718] = {
                    ["cd"] = v719.cd,
                    ["NormalCD"] = v719.NormalCD,
                    ["ULT"] = v719.ULT
                }
            end
        end
        return v716
    end
    return v1
end
local v720 = script.getCDs:InvokeServer()
for v721 = 1, #u5 do
    for v722, v723 in u5[v721] do
        if v720[v721] and v720[v721][v722] then
            v723.cd = v720[v721][v722].cd
        end
    end
end
function script.getCDs.OnClientInvoke(p724) --[[ Line: 1278 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    for _, v725 in p724 do
        local v726 = v725[1]
        local v727 = v725[2]
        local v728 = v725[3]
        if u5[v726] and u5[v726][v727] then
            u5[v726][v727].cd = v728
        end
    end
    warn("client updating cds")
end
return v1