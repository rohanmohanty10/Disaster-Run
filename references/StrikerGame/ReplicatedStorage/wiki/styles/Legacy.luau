 

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = {};
local u2 = { "theme", "oneshotmatchtheme", "percentchancetheme", "rinnoplaytheme" };

local function addStyle(p3: string, p4: table) -- Line: 20
    -- upvalues: u2 (copy), ReplicatedStorage (copy), u1 (copy)
    local u5 = {};

    for i, v in p4 do
        if table.find(u2, i) then
            task.spawn(function() -- Line: 24
                -- upvalues: v (copy), ReplicatedStorage (ref), u5 (copy), i (copy)
                local v6 = v:split("/");
                local Legacy = ReplicatedStorage:WaitForChild("Resources"):WaitForChild("Legacy");
                local v7 = true;

                for _, v2 in ipairs(v6) do
                    Legacy = Legacy:FindFirstChild(v2);

                    if not Legacy then
                        v7 = false;
                        break;
                    end;
                end;

                if v7 then
                    u5[i] = Legacy;

                    return;
                end;

                warn("Unable to find:", table.concat(v6, "."));
            end);
        else
            u5[i] = v;
        end;
    end;

    u1[p3] = u5;
end;

addStyle("isagi", {
    theme = "isagi/theme",
    flowLength = 60,
    flowAnimLength = 4.5,
    tempable = true,
    spec = true,
    color = Color3.fromRGB(49, 104, 255),
    movesets = { { "Direct Shot", "Ball Only" }, "Naruhaya Footwork", { "MY DIRECT SHOT", "Awaken 1" }, { "Two Gun Volley", "Awaken 2" } }
});
addStyle("sae", {
    theme = "sae/sae theme",
    flowLength = 60,
    flowAnimLength = 10.55,
    tempable = true,
    spec = true,
    color = Color3.fromRGB(255, 32, 207),
    movesets = { { "Magic Turn", "Ball" }, { "Nutmeg", "Counter" }, { "Curve Shot", "Ball" }, { "Magic Pass", "Friend Pass" }, { "You i\'ll never surpass me", "Awaken" } }
});
addStyle("nagi", {
    theme = "nagi/nagi theme",
    flowLength = 60,
    flowAnimLength = 7.083333492279053,
    tempable = true,
    spec = true,
    color = Color3.fromRGB(255, 255, 255),
    movesets = { "Fake Volley", { "Control", "Near Ball" }, { "Heavy", "Ball Only" }, { "Nice to meet you, Japan", "Awaken" } }
});
addStyle("shidou", {
    theme = "shidou/shidoutheme",
    flowLength = 60,
    flowAnimLength = 4.8,
    tempable = true,
    spec = true,
    color = Color3.fromRGB(255, 0, 132),
    movesets = { { "Formless", "Air" }, "Back Heel Shot", { "Big Bang Drive", "Awaken 1" }, { "Dragon Drive", "Awaken 2" } }
});
addStyle("kaiser", {
    theme = "kaiser/kaiser theme",
    flowLength = 60,
    flowAnimLength = 8.183333333333334,
    tempable = true,
    spec = true,
    color = Color3.fromRGB(0, 76, 255),
    movesets = { { "Kaiser Impact", "Ball Only" }, { "Kaiser Impact Magnus", "Ball Only" }, "Off the ball", { "Dribble", "Ball Only" }, { "Kaiser Impact Lightning Strike", "Awake" } }
});

return u1;