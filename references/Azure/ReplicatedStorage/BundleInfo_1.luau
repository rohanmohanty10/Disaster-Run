 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = {};

for i, v in require(ReplicatedStorage.wiki).mvp_anim do
    if v.limited then
        table.insert(v1, {
            type = "mvp",
            value = i
        });
    end;
end;

return {
    bundle_tag = "masteryisagiupdate",
    default_bundle = 1,
    bundles = {
        {
            id = 3711671075,
            tag = "MASTERY",
            items = { {
                    type = "mastery_complete",
                    value = "isagi"
                }, {
                    type = "style",
                    value = "nelisagi"
                }, {
                    type = "title",
                    value = "nelisagimasterypaid"
                }, {
                    type = "emote",
                    value = "TalentedLearner"
                }, {
                    type = "mvp",
                    value = "isagiNigeriaWC"
                }, {
                    type = "currency",
                    value = 30000
                } }
        },
        {
            id = 3709556185,
            tag = "MASTERY",
            items = { {
                    type = "mastery_complete",
                    value = "kaiser"
                }, {
                    type = "style",
                    value = "kaiser"
                }, {
                    type = "style",
                    value = "masterykaiser"
                }, {
                    type = "title",
                    value = "masterykaiser"
                }, {
                    type = "emote",
                    value = "masterykaiser"
                }, {
                    type = "mvp",
                    value = "superstarMVP"
                }, {
                    type = "currency",
                    value = 30000
                } }
        },
        {
            id = 3611375979,
            tag = "MASTERY",
            items = { {
                    type = "mastery_complete",
                    value = "aiku"
                }, {
                    type = "style",
                    value = "aiku"
                }, {
                    type = "style",
                    value = "aiku2"
                }, {
                    type = "title",
                    value = "masteryaiku"
                }, {
                    type = "emote",
                    value = "masteryaiku"
                }, {
                    type = "mvp",
                    value = "aikuMVP"
                }, {
                    type = "currency",
                    value = 30000
                } }
        },
        {
            id = 3606914272,
            id2 = 3606914229,
            style_speciality = "yukimiya",
            items = {
                {
                    type = "style",
                    value = "yukimiya"
                },
                {
                    type = "currency",
                    value = 30000
                },
                {
                    type = "emote",
                    value = "streetWear"
                },
                {
                    type = "title",
                    value = "yukititles"
                },
                {
                    type = "pick",
                    value = v1
                }
            }
        }
    },
    item_types = {
        mvp = {
            name = "MVP",
            anchor = true
        },
        currency = {
            name = "Currency",
            format = "$ %s",
            icon = "rbxassetid://16397066979"
        },
        spins = {
            name = "Style Spins",
            format = "%s Spins",
            icon = "rbxassetid://114496992333593"
        },
        style = {
            name = "Style",
            anchor = true
        },
        title = {
            name = "Title",
            anchor = true
        },
        emote = {
            name = "Emote",
            anchor = true
        },
        mastery_complete = {
            name = "Complete Mastery"
        }
    }
};