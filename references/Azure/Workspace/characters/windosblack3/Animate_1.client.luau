 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local _ = workspace.CurrentCamera;
local script_Parent = script.Parent;
local Torso = script_Parent:WaitForChild("Torso");
local u1 = Torso:WaitForChild("Right Shoulder");
local u2 = Torso:WaitForChild("Left Shoulder");
local u3 = Torso:WaitForChild("Right Hip");
local u4 = Torso:WaitForChild("Left Hip");
Torso:WaitForChild("Neck");
local Humanoid = script_Parent:WaitForChild("Humanoid");
script_Parent:WaitForChild("HumanoidRootPart");
local u5 = "Standing";
local LocalPlayer = Players.LocalPlayer;
local success, result = pcall(function() -- Line: 24
    return UserSettings():IsUserFeatureEnabled("UserAnimateScaleRun");
end);
local u6 = success and result;
local replication = require(ReplicatedStorage.client.replication);
local actionUtil = require(ReplicatedStorage.util.actionUtil);
local wiki = require(ReplicatedStorage.wiki);

local function getRigScale() -- Line: 31
    -- upvalues: u6 (copy), script_Parent (copy)
    return not u6 and 1 or script_Parent:GetScale();
end;

local u7 = "";
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = 1;
local u12 = false;
local u13 = false;
local u14 = {};
local u15 = {
    idle = { {
            id = "http://www.roblox.com/asset/?id=180435571",
            weight = 9
        }, {
            id = "http://www.roblox.com/asset/?id=180435792",
            weight = 1
        } },
    idleGoal = { {
            id = "http://www.roblox.com/asset/?id=118047160055719",
            weight = 9
        }, {
            id = "http://www.roblox.com/asset/?id=118047160055719",
            weight = 1
        } },
    idleGoalBall = { {
            id = "http://www.roblox.com/asset/?id=120391641924039",
            weight = 9
        }, {
            id = "http://www.roblox.com/asset/?id=120391641924039",
            weight = 1
        } },
    walk = { {
            id = "http://www.roblox.com/asset/?id=117299500072791",
            weight = 10
        } },
    run = { {
            id = "rbxassetid://96255204467936",
            weight = 10
        } },
    runGK = { {
            id = "http://www.roblox.com/asset/?id=90246958325211",
            weight = 10
        } }
};
local u16 = {
    idle = { {
            id = "http://www.roblox.com/asset/?id=180435571",
            weight = 9
        }, {
            id = "http://www.roblox.com/asset/?id=180435792",
            weight = 1
        } },
    idleGoal = { {
            id = "http://www.roblox.com/asset/?id=136359194332511",
            weight = 9
        }, {
            id = "http://www.roblox.com/asset/?id=136359194332511",
            weight = 1
        } },
    idleGoalBall = { {
            id = "http://www.roblox.com/asset/?id=117211762631778",
            weight = 9
        }, {
            id = "http://www.roblox.com/asset/?id=117211762631778",
            weight = 1
        } },
    walk = { {
            id = "http://www.roblox.com/asset/?id=89766427797413",
            weight = 10
        } },
    gkWalk = { {
            id = "http://www.roblox.com/asset/?id=109758875820507",
            weight = 10
        } },
    walkBall = { {
            id = "http://www.roblox.com/asset/?id=131001189057965",
            weight = 10
        } },
    run = { {
            id = "http://www.roblox.com/asset/?id=90801998022970",
            weight = 10
        } },
    runGK = { {
            id = "http://www.roblox.com/asset/?id=90246958325211",
            weight = 10
        } },
    walkGK = { {
            id = "http://www.roblox.com/asset/?id=117299500072791",
            weight = 10
        } },
    runBall = { {
            id = "http://www.roblox.com/asset/?id=85841393652976",
            weight = 10
        } },
    jump = { {
            id = "http://www.roblox.com/asset/?id=80330677678466",
            weight = 10
        } },
    jumpGK = { {
            id = "http://www.roblox.com/asset/?id=105741699498700",
            weight = 10
        } },
    fall = { {
            id = "http://www.roblox.com/asset/?id=102320563545790",
            weight = 10
        } },
    climb = { {
            id = "http://www.roblox.com/asset/?id=180436334",
            weight = 10
        } },
    sit = { {
            id = "http://www.roblox.com/asset/?id=178130996",
            weight = 10
        } },
    toolnone = { {
            id = "http://www.roblox.com/asset/?id=182393478",
            weight = 10
        } },
    toolslash = { {
            id = "http://www.roblox.com/asset/?id=129967390",
            weight = 10
        } },
    toollunge = { {
            id = "http://www.roblox.com/asset/?id=129967478",
            weight = 10
        } },
    wave = { {
            id = "http://www.roblox.com/asset/?id=128777973",
            weight = 10
        } },
    point = { {
            id = "http://www.roblox.com/asset/?id=128853357",
            weight = 10
        } },
    dance1 = { {
            id = "http://www.roblox.com/asset/?id=182435998",
            weight = 10
        }, {
            id = "http://www.roblox.com/asset/?id=182491037",
            weight = 10
        }, {
            id = "http://www.roblox.com/asset/?id=182491065",
            weight = 10
        } },
    dance2 = { {
            id = "http://www.roblox.com/asset/?id=182436842",
            weight = 10
        }, {
            id = "http://www.roblox.com/asset/?id=182491248",
            weight = 10
        }, {
            id = "http://www.roblox.com/asset/?id=182491277",
            weight = 10
        } },
    dance3 = { {
            id = "http://www.roblox.com/asset/?id=182436935",
            weight = 10
        }, {
            id = "http://www.roblox.com/asset/?id=182491368",
            weight = 10
        }, {
            id = "http://www.roblox.com/asset/?id=182491423",
            weight = 10
        } },
    laugh = { {
            id = "http://www.roblox.com/asset/?id=129423131",
            weight = 10
        } },
    cheer = { {
            id = "http://www.roblox.com/asset/?id=129423030",
            weight = 10
        } }
};
local u17 = {
    rin = {
        flow_idle = { {
                id = "http://www.roblox.com/asset/?id=125255312609677",
                weight = 9
            } },
        flow_walk = { {
                id = "http://www.roblox.com/asset/?id=121742954115798",
                weight = 10
            } },
        flow_run = { {
                id = "http://www.roblox.com/asset/?id=96842126327651",
                weight = 10
            } }
    },
    rin2 = {
        flow_idle = { {
                id = "http://www.roblox.com/asset/?id=125255312609677",
                weight = 9
            } },
        flow_walk = { {
                id = "http://www.roblox.com/asset/?id=121742954115798",
                weight = 10
            } },
        flow_run = { {
                id = "http://www.roblox.com/asset/?id=96842126327651",
                weight = 10
            } }
    },
    barou = {
        mobian_idle = { {
                id = "https://www.roblox.com/asset/?id=98521647305152",
                weight = 9
            } },
        mobian_run = { {
                id = "https://www.roblox.com/asset/?id=106080083383155",
                weight = 10
            } }
    },
    kurona = {
        mobian_idle = { {
                id = "https://www.roblox.com/asset/?id=110463933227157",
                weight = 9
            } },
        mobian_run = { {
                id = "https://www.roblox.com/asset/?id=103401650048812",
                weight = 10
            } }
    },
    dio = {
        idle = { {
                id = "https://www.roblox.com/asset/?id=73438910267204",
                weight = 9
            } },
        walk = { {
                id = "https://www.roblox.com/asset/?id=108247791319994",
                weight = 10
            } },
        run = { {
                id = "https://www.roblox.com/asset/?id=129949906631605",
                weight = 10
            } }
    },
    sonic = {
        idle = { {
                id = "https://www.roblox.com/asset/?id=104654653366636",
                weight = 9
            } },
        overtime_flow_idle = { {
                id = "https://www.roblox.com/asset/?id=116168845420023",
                weight = 9
            } },
        break_in = { {
                id = "https://www.roblox.com/asset/?id=127057390075533",
                weight = 10
            }, {
                id = "https://www.roblox.com/asset/?id=79693564010743",
                weight = 10
            } },
        overtime_flow_break_in = { {
                id = "https://www.roblox.com/asset/?id=86915720798804",
                weight = 10,
                replicate = "sonic_idleflow"
            } },
        overtime_flow_run = { {
                id = "https://www.roblox.com/asset/?id=135707090858090",
                weight = 10
            } },
        run = { {
                id = "https://www.roblox.com/asset/?id=119645947876970",
                weight = 10
            } }
    },
    exe = {
        idle = { {
                id = "https://www.roblox.com/asset/?id=103822262065344",
                weight = 9
            } },
        flow_idle = { {
                id = "https://www.roblox.com/asset/?id=116168845420023",
                weight = 9
            } },
        run = { {
                id = "https://www.roblox.com/asset/?id=107879778399662",
                weight = 10
            } },
        flow_run = { {
                id = "https://www.roblox.com/asset/?id=135707090858090",
                weight = 10
            } }
    },
    cid = {
        idle = { {
                id = "https://www.roblox.com/asset/?id=121930209009553",
                weight = 9
            } },
        run = { {
                id = "https://www.roblox.com/asset/?id=134161593477512",
                weight = 10
            } }
    },
    roland = {
        idle = { {
                id = "https://www.roblox.com/asset/?id=102181170968104",
                weight = 9
            } },
        rnp_idle = { {
                id = "https://www.roblox.com/asset/?id=75919736955625",
                weight = 9
            } },
        rnp_base_idle = { {
                id = "https://www.roblox.com/asset/?id=119120755599276",
                weight = 9
            } },
        rnp_run = { {
                id = "https://www.roblox.com/asset/?id=114579813534174",
                weight = 10
            } }
    },
    ["2011x"] = {
        flow_idle = { {
                id = "https://www.roblox.com/asset/?id=124368502537065",
                weight = 9,
                replicate = "elevenX_idleflow"
            } },
        idle = { {
                id = "https://www.roblox.com/asset/?id=103822262065344",
                weight = 9
            } },
        run = { {
                id = "https://www.roblox.com/asset/?id=107879778399662",
                weight = 10
            } }
    },
    akuma = {
        idle = { {
                id = "https://www.roblox.com/asset/?id=71405527360715",
                weight = 9
            } },
        run = { {
                id = "https://www.roblox.com/asset/?id=95939017390281",
                weight = 10
            } },
        walk = { {
                id = "https://www.roblox.com/asset/?id=137307061262960",
                weight = 10
            } }
    },
    gremmy = {
        idle = { {
                id = "https://www.roblox.com/asset/?id=139530702970827",
                weight = 9
            } },
        run = { {
                id = "https://www.roblox.com/asset/?id=104467473561897",
                weight = 10
            } }
    },
    akashi = {
        ball_idle = { {
                id = "https://www.roblox.com/asset/?id=132705861159141",
                weight = 9
            } },
        ball_idle2 = { {
                id = "https://www.roblox.com/asset/?id=88509904132304",
                weight = 9
            } },
        ball_run = { {
                id = "https://www.roblox.com/asset/?id=113507508658257",
                weight = 10
            } },
        ball_run2 = { {
                id = "https://www.roblox.com/asset/?id=113320301841465",
                weight = 10
            } }
    }
};
local u18 = 0;

function configureAnimationSet(u19, u20)
    -- upvalues: u15 (copy), u14 (copy)
    local v21 = u15[u19];

    if u14[u19] ~= nil then
        for _, v in pairs(u14[u19].connections) do
            v:disconnect();
        end;
    end;

    u14[u19] = {};
    u14[u19].count = 0;
    u14[u19].totalWeight = 0;
    u14[u19].connections = {};
    local v22 = script:FindFirstChild(u19);

    if v22 ~= nil then
        table.insert(u14[u19].connections, v22.ChildAdded:connect(function(p23) -- Line: 359
            -- upvalues: u19 (copy), u20 (copy)
            configureAnimationSet(u19, u20);
        end));
        table.insert(u14[u19].connections, v22.ChildRemoved:connect(function(p24) -- Line: 360
            -- upvalues: u19 (copy), u20 (copy)
            configureAnimationSet(u19, u20);
        end));
        local v25 = 1;

        for _, child in pairs(v22:GetChildren()) do
            if child:IsA("Animation") then
                table.insert(u14[u19].connections, child.Changed:connect(function(p26) -- Line: 364
                    -- upvalues: u19 (copy), u20 (copy)
                    configureAnimationSet(u19, u20);
                end));
                u14[u19][v25] = {};
                u14[u19][v25].anim = child;
                local Weight = child:FindFirstChild("Weight");

                if Weight == nil then
                    u14[u19][v25].weight = 1;
                else
                    u14[u19][v25].weight = Weight.Value;
                end;

                u14[u19].count = u14[u19].count + 1;
                u14[u19].totalWeight = u14[u19].totalWeight + u14[u19][v25].weight;
                v25 = v25 + 1;
            end;
        end;
    end;

    if u14[u19].count <= 0 then
        for i, v in pairs(u20) do
            u14[u19][i] = {};
            u14[u19][i].anim = Instance.new("Animation");
            u14[u19][i].anim.Name = u19;
            u14[u19][i].anim.AnimationId = v.id;
            u14[u19][i].weight = v.weight;
            u14[u19][i].replicate = v.replicate;
            u14[u19].count = u14[u19].count + 1;
            u14[u19].totalWeight = u14[u19].totalWeight + v.weight;
        end;
    end;

    if v21 then
        for i, v in pairs(v21) do
            u14[u19][i].oldanim = Instance.new("Animation");
            u14[u19][i].oldanim.Name = u19;
            u14[u19][i].oldanim.AnimationId = v.id;
        end;
    end;
end;

function scriptChildModified(p27)
    -- upvalues: u16 (copy)
    local v28 = u16[p27.Name];

    if v28 ~= nil then
        configureAnimationSet(p27.Name, v28);
    end;
end;

local v29;

if Humanoid then
    v29 = Humanoid:FindFirstChildOfClass("Animator");
else
    v29 = nil;
end;

if v29 then
    local PlayingAnimationTracks = v29:GetPlayingAnimationTracks();

    for _, v in ipairs(PlayingAnimationTracks) do
        v:Stop(0);
        v:Destroy();
    end;
end;

for i, v in pairs(u16) do
    configureAnimationSet(i, v);
end;

for i, v in pairs(u17) do
    local v30 = i;

    for i2, v2 in pairs(v) do
        configureAnimationSet(`{v30}_{i2}`, v2);
    end;
end;

local u31 = "None";
local u32 = 0;
local u33 = 0;

local function isIdleReplicationFrozen() -- Line: 452
    -- upvalues: actionUtil (copy), script_Parent (copy)
    local workspace2 = actionUtil.getworkspace();

    if workspace2 then
        workspace2 = workspace2:FindFirstChild("disabled");
    end;

    local v34;

    if script_Parent:GetAttribute("frozen") == true then
        v34 = true;
    elseif workspace2 == nil then
        v34 = false;
    else
        v34 = workspace2.Value;
    end;

    return v34;
end;

function stopAllAnimations()
    -- upvalues: u7 (ref), u8 (ref), u12 (ref), u10 (ref), u9 (ref)
    local v35 = u7;
    u7 = "";
    u8 = nil;
    u12 = false;

    if u10 ~= nil then
        u10:disconnect();
    end;

    if u9 ~= nil then
        u9:Stop();
        u9:Destroy();
        u9 = nil;
    end;

    return v35;
end;

function setAnimationSpeed(p36)
    -- upvalues: u11 (ref), u9 (ref)
    if p36 ~= u11 then
        u11 = p36;
        u9:AdjustSpeed(u11);
    end;
end;

function keyFrameReachedFunc(p37)
    -- upvalues: u7 (ref), u18 (ref), u11 (ref), Humanoid (copy)
    if p37 == "End" then
        if string.match(u7, "_break_in") then
            u18 = 0;
            onIdle();

            return;
        end;

        playAnimation(u7, 0, Humanoid);
        setAnimationSpeed(u11);
    end;
end;

function playAnimation(p38, p39, p40)
    -- upvalues: u14 (copy), actionUtil (copy), LocalPlayer (copy), u8 (ref), u7 (ref), u9 (ref), u11 (ref), replication (copy), u12 (ref), script_Parent (copy), u13 (ref), u10 (ref)
    local math_random_ret = math.random(1, u14[p38].totalWeight);
    local v41 = 1;

    while u14[p38][v41].weight < math_random_ret do
        math_random_ret = math_random_ret - u14[p38][v41].weight;
        v41 = v41 + 1;
    end;

    local anim = u14[p38][v41].anim;

    if table.find({ "Release", "v1.3", "v1.5" }, actionUtil.checkReleaseStyle(LocalPlayer.character)) and u14[p38][v41].oldanim then
        anim = u14[p38][v41].oldanim;
    end;

    if anim ~= u8 or p38 ~= u7 then
        if u9 ~= nil then
            u9:Stop(p39);
            u9:Destroy();
        end;

        u11 = 1;
        u9 = p40:LoadAnimation(anim);
        u9.Priority = Enum.AnimationPriority.Core;
        u9:Play(p39);
        u7 = p38;
        u8 = anim;
        local replicate = u14[p38][v41].replicate;

        if replicate then
            replicate = replication[replicate];
        end;

        u12 = replicate ~= nil;

        if replicate then
            local workspace2 = actionUtil.getworkspace();

            if workspace2 then
                workspace2 = workspace2:FindFirstChild("disabled");
            end;

            local v42;

            if script_Parent:GetAttribute("frozen") == true then
                v42 = true;
            elseif workspace2 == nil then
                v42 = false;
            else
                v42 = workspace2.Value;
            end;

            if v42 then
                u13 = true;
            else
                local u43 = u9;
                task.spawn(function() -- Line: 556
                    -- upvalues: u9 (ref), u43 (copy), actionUtil (ref), script_Parent (ref), u13 (ref), replicate (copy)
                    if u9 ~= u43 or not u43.IsPlaying then
                        return;
                    end;

                    local workspace3 = actionUtil.getworkspace();

                    if workspace3 then
                        workspace3 = workspace3:FindFirstChild("disabled");
                    end;

                    local v44;

                    if script_Parent:GetAttribute("frozen") == true then
                        v44 = true;
                    elseif workspace3 == nil then
                        v44 = false;
                    else
                        v44 = workspace3.Value;
                    end;

                    if v44 then
                        u13 = true;

                        return;
                    end;

                    replicate(script_Parent, u43);
                end);
            end;
        end;

        if u10 ~= nil then
            u10:disconnect();
        end;

        u10 = u9.KeyframeReached:connect(keyFrameReachedFunc);
    end;
end;

local u45 = "";
local u46 = nil;
local u47 = nil;
local u48 = nil;

function toolKeyFrameReachedFunc(p49)
    -- upvalues: u45 (ref), Humanoid (copy)
    if p49 == "End" then
        playToolAnimation(u45, 0, Humanoid);
    end;
end;

function playToolAnimation(p50, p51, p52, p53)
    -- upvalues: u14 (copy), u47 (ref), u46 (ref), u45 (ref), u48 (ref)
    local math_random_ret = math.random(1, u14[p50].totalWeight);
    local v54 = 1;

    while u14[p50][v54].weight < math_random_ret do
        math_random_ret = math_random_ret - u14[p50][v54].weight;
        v54 = v54 + 1;
    end;

    local anim = u14[p50][v54].anim;

    if u47 ~= anim then
        if u46 ~= nil then
            u46:Stop();
            u46:Destroy();
            p51 = 0;
        end;

        u46 = p52:LoadAnimation(anim);

        if p53 then
            u46.Priority = p53;
        end;

        u46:Play(p51);
        u45 = p50;
        u47 = anim;
        u48 = u46.KeyframeReached:connect(toolKeyFrameReachedFunc);
    end;
end;

function stopToolAnimations()
    -- upvalues: u45 (ref), u48 (ref), u47 (ref), u46 (ref)
    local v55 = u45;

    if u48 ~= nil then
        u48:disconnect();
    end;

    u45 = "";
    u47 = nil;

    if u46 ~= nil then
        u46:Stop();
        u46:Destroy();
        u46 = nil;
    end;

    return v55;
end;

local function isOvertimeFlow() -- Line: 652
    -- upvalues: ReplicatedStorage (copy), actionUtil (copy), script_Parent (copy)
    local workspace2 = ReplicatedStorage:FindFirstChild("workspace");

    if workspace2 then
        workspace2 = workspace2:FindFirstChild("overtime");
    end;

    local v56 = actionUtil.checkflow(script_Parent);

    if v56 then
        v56 = script_Parent:HasTag("overtimeTest");

        if not v56 then
            if workspace2 == nil then
                v56 = false;
            else
                v56 = workspace2.Value == true;
            end;
        end;
    end;

    return v56;
end;

function onIdle()
    -- upvalues: actionUtil (copy), script_Parent (copy), Humanoid (copy), LocalPlayer (copy), u17 (copy), ReplicatedStorage (copy), u5 (ref)
    if actionUtil.checkGK(script_Parent) then
        if actionUtil.checkball(script_Parent) then
            playAnimation("idleGoalBall", 0.1, Humanoid);
        else
            playAnimation("idleGoal", 0.1, Humanoid);
        end;
    else
        local v57 = actionUtil.checkStyle(LocalPlayer);
        local v58 = u17[v57];
        local Attribute = script_Parent:GetAttribute("DestructiveImpulses");

        if v58 and v58.overtime_flow_idle then
            local workspace2 = ReplicatedStorage:FindFirstChild("workspace");

            if workspace2 then
                workspace2 = workspace2:FindFirstChild("overtime");
            end;

            local v59 = actionUtil.checkflow(script_Parent);

            if v59 then
                v59 = script_Parent:HasTag("overtimeTest");

                if not v59 then
                    if workspace2 == nil then
                        v59 = false;
                    else
                        v59 = workspace2.Value == true;
                    end;
                end;
            end;

            if v59 then
                playAnimation(`{v57}_overtime_flow_idle`, 0.1, Humanoid);
            elseif v58 and (v58.flow_idle and (Attribute or actionUtil.checkflow(script_Parent))) then
                playAnimation(`{v57}_flow_idle`, 0.1, Humanoid);
            elseif v58 and (v58.mobian_idle and script_Parent:GetAttribute("mobian")) then
                playAnimation(`{v57}_mobian_idle`, 0.1, Humanoid);
            elseif v58 and (v58.rnp_idle and script_Parent:GetAttribute("RolandScythe")) then
                playAnimation(`{v57}_rnp_idle`, 0.1, Humanoid);
            elseif v58 and (v58.rnp_base_idle and script_Parent:GetAttribute("RinNoPlay")) then
                playAnimation(`{v57}_rnp_base_idle`, 0.1, Humanoid);
            elseif v57 == "akashi" and (actionUtil.checkball(script_Parent) and (v58 and (v58.ball_idle2 and script_Parent:GetAttribute("hand_use") == 2))) then
                playAnimation(`{v57}_ball_idle2`, 0.1, Humanoid);
            elseif v57 == "akashi" and (actionUtil.checkball(script_Parent) and (v58 and v58.ball_idle)) then
                playAnimation(`{v57}_ball_idle`, 0.1, Humanoid);
            elseif v58 and v58.idle then
                playAnimation(`{v57}_idle`, 0.1, Humanoid);
            else
                playAnimation("idle", 0.1, Humanoid);
            end;
        elseif v58 and (v58.flow_idle and (Attribute or actionUtil.checkflow(script_Parent))) then
            playAnimation(`{v57}_flow_idle`, 0.1, Humanoid);
        elseif v58 and (v58.mobian_idle and script_Parent:GetAttribute("mobian")) then
            playAnimation(`{v57}_mobian_idle`, 0.1, Humanoid);
        elseif v58 and (v58.rnp_idle and script_Parent:GetAttribute("RolandScythe")) then
            playAnimation(`{v57}_rnp_idle`, 0.1, Humanoid);
        elseif v58 and (v58.rnp_base_idle and script_Parent:GetAttribute("RinNoPlay")) then
            playAnimation(`{v57}_rnp_base_idle`, 0.1, Humanoid);
        elseif v57 == "akashi" and (actionUtil.checkball(script_Parent) and (v58 and (v58.ball_idle2 and script_Parent:GetAttribute("hand_use") == 2))) then
            playAnimation(`{v57}_ball_idle2`, 0.1, Humanoid);
        elseif v57 == "akashi" and (actionUtil.checkball(script_Parent) and (v58 and v58.ball_idle)) then
            playAnimation(`{v57}_ball_idle`, 0.1, Humanoid);
        elseif v58 and v58.idle then
            playAnimation(`{v57}_idle`, 0.1, Humanoid);
        else
            playAnimation("idle", 0.1, Humanoid);
        end;
    end;

    u5 = "Standing";
end;

local function getExpectedIdle(p60, p61) -- Line: 699
    -- upvalues: ReplicatedStorage (copy), actionUtil (copy), script_Parent (copy)
    if p61 and p61.overtime_flow_idle then
        local workspace2 = ReplicatedStorage:FindFirstChild("workspace");

        if workspace2 then
            workspace2 = workspace2:FindFirstChild("overtime");
        end;

        local v62 = actionUtil.checkflow(script_Parent);

        if v62 then
            v62 = script_Parent:HasTag("overtimeTest");

            if not v62 then
                if workspace2 == nil then
                    v62 = false;
                else
                    v62 = workspace2.Value == true;
                end;
            end;
        end;

        if v62 then
            return `{p60}_overtime_flow_idle`;
        end;
    end;

    if p61 and (p61.flow_idle and actionUtil.checkflow(script_Parent)) then
        return `{p60}_flow_idle`;
    end;

    if p61 and (p61.mobian_idle and script_Parent:GetAttribute("mobian")) then
        return `{p60}_mobian_idle`;
    end;

    if p61 and (p61.rnp_idle and script_Parent:GetAttribute("RolandScythe")) then
        return `{p60}_rnp_idle`;
    end;

    if p61 and (p61.rnp_base_idle and script_Parent:GetAttribute("RinNoPlay")) then
        return `{p60}_rnp_base_idle`;
    end;

    if p60 == "akashi" and (actionUtil.checkball(script_Parent) and (p61 and (p61.ball_idle2 and script_Parent:GetAttribute("hand_use") == 2))) then
        return `{p60}_ball_idle2`;
    end;

    if p60 == "akashi" and (actionUtil.checkball(script_Parent) and (p61 and p61.ball_idle)) then
        return `{p60}_ball_idle`;
    end;

    if p61 and p61.idle then
        return `{p60}_idle`;
    end;
end;

local function updateBreakins(p63) -- Line: 733
    -- upvalues: ReplicatedStorage (copy), u18 (ref), actionUtil (copy), LocalPlayer (copy), script_Parent (copy), u17 (copy), u14 (copy), u5 (ref), u7 (ref), getExpectedIdle (copy), Humanoid (copy), u9 (ref)
    if ReplicatedStorage:FindFirstChild("workspace") and ReplicatedStorage.workspace.disabled.Value then
        u18 = 0;

        return;
    end;

    local v64 = actionUtil.checkStyle(LocalPlayer);
    local v65 = actionUtil.checkflow(script_Parent);
    local Attribute = script_Parent:GetAttribute("DestructiveImpulses");
    local v66 = u17[v64];
    local v67 = v66 and v66.overtime_flow_break_in;

    if v67 then
        local workspace2 = ReplicatedStorage:FindFirstChild("workspace");

        if workspace2 then
            workspace2 = workspace2:FindFirstChild("overtime");
        end;

        v67 = actionUtil.checkflow(script_Parent);

        if v67 then
            v67 = script_Parent:HasTag("overtimeTest");

            if not v67 then
                if workspace2 == nil then
                    v67 = false;
                else
                    v67 = workspace2.Value == true;
                end;
            end;
        end;
    end;

    local u68;

    if v67 then
        u68 = `{v64}_overtime_flow_break_in`;
    elseif Attribute or v65 then
        u68 = `{v64}_flow_break_in`;
    else
        u68 = `{v64}_break_in`;
    end;

    if not (v66 and (v67 or v65 and v66.flow_break_in or v66.break_in)) then
        u18 = 0;

        return;
    end;

    if not (u14[u68] and (u14[u68].count > 0 and u14[u68].totalWeight > 0)) then
        u18 = 0;

        return;
    end;

    if u5 ~= "Standing" or (actionUtil.checkGK(script_Parent) or (u7 ~= getExpectedIdle(v64, v66) or Humanoid.MoveDirection.Magnitude > 0.01)) then
        u18 = 0;

        return;
    end;

    u18 = u18 + p63;

    if u18 >= 10 then
        u18 = 0;
        u5 = "Breakin";
        playAnimation(u68, 0.1, Humanoid);
        local u69 = u9;

        if u69 then
            u69.Ended:Once(function() -- Line: 774
                -- upvalues: u9 (ref), u69 (copy), u7 (ref), u68 (copy), u5 (ref)
                if u9 == u69 and u7 == u68 then
                    u5 = "Standing";
                end;
            end);
        end;
    end;
end;

function onRunning(p70)
    -- upvalues: Humanoid (copy), u6 (copy), script_Parent (copy), u5 (ref), wiki (copy), actionUtil (copy), LocalPlayer (copy), u17 (copy), ReplicatedStorage (copy)
    local v71 = (p70 or Humanoid.WalkSpeed) / (not u6 and 1 or script_Parent:GetScale());

    if u5 == "Breakin" and Humanoid.MoveDirection.Magnitude <= 0.05 then
        return;
    end;

    if v71 <= 0.01 then
        if u5 ~= "Breakin" then
            onIdle();
        end;

        return;
    end;

    if wiki.walkspeed + 3.5 <= v71 then
        if actionUtil.checkGK(script_Parent) and actionUtil.checkball(script_Parent) then
            playAnimation("runBall", 0.1, Humanoid);
        else
            local v72 = actionUtil.checkStyle(LocalPlayer);
            local v73 = u17[v72];
            local Attribute = script_Parent:GetAttribute("DestructiveImpulses");

            if v73 and v73.overtime_flow_run then
                local workspace2 = ReplicatedStorage:FindFirstChild("workspace");

                if workspace2 then
                    workspace2 = workspace2:FindFirstChild("overtime");
                end;

                local v74 = actionUtil.checkflow(script_Parent);

                if v74 then
                    v74 = script_Parent:HasTag("overtimeTest");

                    if not v74 then
                        if workspace2 == nil then
                            v74 = false;
                        else
                            v74 = workspace2.Value == true;
                        end;
                    end;
                end;

                if v74 then
                    playAnimation(`{v72}_overtime_flow_run`, 0.1, Humanoid);
                elseif v73 and (v73.flow_run and (Attribute or actionUtil.checkflow(script_Parent))) then
                    playAnimation(`{v72}_flow_run`, 0.1, Humanoid);
                elseif actionUtil.checkGK(script_Parent) then
                    playAnimation("runGK", 0.1, Humanoid);
                elseif v73 and (v73.mobian_run and script_Parent:GetAttribute("mobian")) then
                    playAnimation(`{v72}_mobian_run`, 0.1, Humanoid);
                elseif v73 and (v73.rnp_run and script_Parent:GetAttribute("RolandScythe")) then
                    playAnimation(`{v72}_rnp_run`, 0.1, Humanoid);
                elseif v72 == "akashi" and (actionUtil.checkball(script_Parent) and (v73 and (v73.ball_run2 and script_Parent:GetAttribute("hand_use") == 2))) then
                    playAnimation(`{v72}_ball_run2`, 0.1, Humanoid);
                elseif v72 == "akashi" and (actionUtil.checkball(script_Parent) and (v73 and v73.ball_run)) then
                    playAnimation(`{v72}_ball_run`, 0.1, Humanoid);
                elseif v73 and v73.run then
                    playAnimation(`{v72}_run`, 0.1, Humanoid);
                else
                    playAnimation("run", 0.1, Humanoid);
                end;
            elseif v73 and (v73.flow_run and (Attribute or actionUtil.checkflow(script_Parent))) then
                playAnimation(`{v72}_flow_run`, 0.1, Humanoid);
            elseif actionUtil.checkGK(script_Parent) then
                playAnimation("runGK", 0.1, Humanoid);
            elseif v73 and (v73.mobian_run and script_Parent:GetAttribute("mobian")) then
                playAnimation(`{v72}_mobian_run`, 0.1, Humanoid);
            elseif v73 and (v73.rnp_run and script_Parent:GetAttribute("RolandScythe")) then
                playAnimation(`{v72}_rnp_run`, 0.1, Humanoid);
            elseif v72 == "akashi" and (actionUtil.checkball(script_Parent) and (v73 and (v73.ball_run2 and script_Parent:GetAttribute("hand_use") == 2))) then
                playAnimation(`{v72}_ball_run2`, 0.1, Humanoid);
            elseif v72 == "akashi" and (actionUtil.checkball(script_Parent) and (v73 and v73.ball_run)) then
                playAnimation(`{v72}_ball_run`, 0.1, Humanoid);
            elseif v73 and v73.run then
                playAnimation(`{v72}_run`, 0.1, Humanoid);
            else
                playAnimation("run", 0.1, Humanoid);
            end;
        end;

        setAnimationSpeed(v71 / 35);
    else
        if actionUtil.checkGK(script_Parent) and actionUtil.checkball(script_Parent) then
            playAnimation("walkBall", 0.1, Humanoid);
        else
            local v75 = actionUtil.checkStyle(LocalPlayer);
            local v76 = u17[v75];
            local Attribute = script_Parent:GetAttribute("DestructiveImpulses");

            if v76 and v76.overtime_flow_walk then
                local workspace2 = ReplicatedStorage:FindFirstChild("workspace");

                if workspace2 then
                    workspace2 = workspace2:FindFirstChild("overtime");
                end;

                local v77 = actionUtil.checkflow(script_Parent);

                if v77 then
                    v77 = script_Parent:HasTag("overtimeTest");

                    if not v77 then
                        if workspace2 == nil then
                            v77 = false;
                        else
                            v77 = workspace2.Value == true;
                        end;
                    end;
                end;

                if v77 then
                    playAnimation(`{v75}_overtime_flow_walk`, 0.1, Humanoid);
                elseif v76 and (v76.flow_walk and (Attribute or actionUtil.checkflow(script_Parent))) then
                    playAnimation(`{v75}_flow_walk`, 0.1, Humanoid);
                elseif actionUtil.checkGK(script_Parent) then
                    playAnimation("walkGK", 0.1, Humanoid);
                elseif v76 and v76.walk then
                    playAnimation(`{v75}_walk`, 0.1, Humanoid);
                else
                    playAnimation("walk", 0.1, Humanoid);
                end;
            elseif v76 and (v76.flow_walk and (Attribute or actionUtil.checkflow(script_Parent))) then
                playAnimation(`{v75}_flow_walk`, 0.1, Humanoid);
            elseif actionUtil.checkGK(script_Parent) then
                playAnimation("walkGK", 0.1, Humanoid);
            elseif v76 and v76.walk then
                playAnimation(`{v75}_walk`, 0.1, Humanoid);
            else
                playAnimation("walk", 0.1, Humanoid);
            end;
        end;

        setAnimationSpeed(v71 / (wiki.walkspeed - 1));
    end;

    u5 = "Running";
end;

function onDied()
    -- upvalues: u5 (ref)
    u5 = "Dead";
end;

function onJumping()
    -- upvalues: Humanoid (copy), u33 (ref), u5 (ref)
    playAnimation("jump", 0.1, Humanoid);
    u33 = 0.3;
    u5 = "Jumping";
end;

function onClimbing(p78)
    -- upvalues: u6 (copy), script_Parent (copy), Humanoid (copy), u5 (ref)
    local v79 = p78 / (not u6 and 1 or script_Parent:GetScale());
    playAnimation("climb", 0.1, Humanoid);
    setAnimationSpeed(v79 / 12);
    u5 = "Climbing";
end;

function onGettingUp()
    -- upvalues: u5 (ref)
    u5 = "GettingUp";
end;

function onFreeFall()
    -- upvalues: u33 (ref), Humanoid (copy), u5 (ref)
    if u33 <= 0 then
        playAnimation("fall", 0.3, Humanoid);
    end;

    u5 = "FreeFall";
end;

function onFallingDown()
    -- upvalues: u5 (ref)
    u5 = "FallingDown";
end;

function onSeated()
    -- upvalues: u5 (ref)
    u5 = "Seated";
end;

function onPlatformStanding()
    -- upvalues: u5 (ref)
    u5 = "PlatformStanding";
end;

function onSwimming(p80)
    -- upvalues: u5 (ref)
    if p80 > 0 then
        u5 = "Running";

        return;
    end;

    u5 = "Standing";
end;

function getTool()
    -- upvalues: script_Parent (copy)
    for _, child in ipairs(script_Parent:GetChildren()) do
        if child.className == "Tool" then
            return child;
        end;
    end;

    return nil;
end;

function getToolAnim(p81)
    for _, child in ipairs(p81:GetChildren()) do
        if child.Name == "toolanim" and child.className == "StringValue" then
            return child;
        end;
    end;

    return nil;
end;

function animateTool()
    -- upvalues: u31 (ref), Humanoid (copy)
    if u31 == "None" then
        playToolAnimation("toolnone", 0.1, Humanoid, Enum.AnimationPriority.Idle);

        return;
    end;

    if u31 == "Slash" then
        playToolAnimation("toolslash", 0, Humanoid, Enum.AnimationPriority.Action);

        return;
    end;

    if u31 ~= "Lunge" then
        return;
    end;

    playToolAnimation("toollunge", 0, Humanoid, Enum.AnimationPriority.Action);
end;

function moveSit()
    -- upvalues: u1 (copy), u2 (copy), u3 (copy), u4 (copy)
    u1.MaxVelocity = 0.15;
    u2.MaxVelocity = 0.15;
    u1:SetDesiredAngle(1.57);
    u2:SetDesiredAngle(-1.57);
    u3:SetDesiredAngle(1.57);
    u4:SetDesiredAngle(-1.57);
end;

local u82 = 0;

function move(p83)
    -- upvalues: u82 (ref), u33 (ref), u5 (ref), Humanoid (copy), actionUtil (copy), script_Parent (copy), u1 (copy), u2 (copy), u3 (copy), u4 (copy), u31 (ref), u32 (ref), u47 (ref)
    local v84 = 1;
    local v85 = 1;
    local v86 = p83 - u82;
    u82 = p83;
    local v87 = false;

    if u33 > 0 then
        u33 = u33 - v86;
    end;

    if u5 == "FreeFall" and u33 <= 0 then
        playAnimation("fall", 0.3, Humanoid);
    else
        if u5 == "Seated" then
            playAnimation("sit", 0.5, Humanoid);

            return;
        end;

        if u5 == "Running" then
            if actionUtil.checkGK(script_Parent) and actionUtil.checkball(script_Parent) then
                playAnimation("runBall", 0.1, Humanoid);
            end;
        elseif u5 == "Standing" then
            if actionUtil.checkGK(script_Parent) then
                if actionUtil.checkball(script_Parent) then
                    playAnimation("idleGoalBall", 0.1, Humanoid);
                else
                    playAnimation("idleGoal", 0.1, Humanoid);
                end;
            end;
        elseif u5 == "Dead" or (u5 == "GettingUp" or (u5 == "FallingDown" or (u5 == "Seated" or u5 == "PlatformStanding"))) then
            stopAllAnimations();
            v87 = true;
            v85 = 1;
            v84 = 0.1;
        end;
    end;

    if v87 then
        local v88 = v84 * math.sin(p83 * v85);
        u1:SetDesiredAngle(v88 + 0);
        u2:SetDesiredAngle(v88 - 0);
        u3:SetDesiredAngle(-v88);
        u4:SetDesiredAngle(-v88);
    end;

    local v89 = getTool();

    if v89 and v89:FindFirstChild("Handle") then
        local v90 = getToolAnim(v89);

        if v90 then
            u31 = v90.Value;
            v90.Parent = nil;
            u32 = p83 + 0.3;
        end;

        if u32 < p83 then
            u32 = 0;
            u31 = "None";
        end;

        animateTool();

        return;
    end;

    stopToolAnimations();
    u31 = "None";
    u47 = nil;
    u32 = 0;
end;

Humanoid.Died:connect(onDied);
Humanoid.Running:connect(onRunning);
Humanoid.Jumping:connect(onJumping);
Humanoid.Climbing:connect(onClimbing);
Humanoid.GettingUp:connect(onGettingUp);
Humanoid.FreeFalling:connect(onFreeFall);
Humanoid.FallingDown:connect(onFallingDown);
Humanoid.Seated:connect(onSeated);
Humanoid.PlatformStanding:connect(onPlatformStanding);
Humanoid.Swimming:connect(onSwimming);

local function updateIdleReplicationFreeze() -- Line: 1068
    -- upvalues: actionUtil (copy), script_Parent (copy), u18 (ref), u12 (ref), u13 (ref), u5 (ref), Humanoid (copy)
    local workspace2 = actionUtil.getworkspace();

    if workspace2 then
        workspace2 = workspace2:FindFirstChild("disabled");
    end;

    local v91;

    if script_Parent:GetAttribute("frozen") == true then
        v91 = true;
    elseif workspace2 == nil then
        v91 = false;
    else
        v91 = workspace2.Value;
    end;

    if v91 then
        u18 = 0;

        if u12 then
            u13 = true;
            stopAllAnimations();

            if u5 == "Breakin" then
                u5 = "Standing";
            end;
        end;

        return;
    end;

    if not u13 then
        return;
    end;

    u13 = false;

    if Humanoid.Health > 0 and (Humanoid.MoveDirection.Magnitude <= 0.01 and (u5 == "Standing" or u5 == "Breakin")) then
        stopAllAnimations();
        onIdle();
    end;
end;

script_Parent:GetAttributeChangedSignal("frozen"):Connect(updateIdleReplicationFreeze);
local u92 = nil;
script.Destroying:Once(function() -- Line: 1095
    -- upvalues: u92 (ref)
    if u92 then
        u92:Disconnect();
    end;
end);
task.spawn(function() -- Line: 1101
    -- upvalues: ReplicatedStorage (copy), script_Parent (copy), u92 (ref), updateIdleReplicationFreeze (copy)
    local workspace2 = ReplicatedStorage:WaitForChild("workspace", 30);

    if workspace2 then
        workspace2 = workspace2:WaitForChild("disabled", 30);
    end;

    if not (workspace2 and (script_Parent.Parent and script.Parent)) then
        return;
    end;

    u92 = workspace2:GetPropertyChangedSignal("Value"):Connect(updateIdleReplicationFreeze);
    updateIdleReplicationFreeze();
end);
onIdle();
script_Parent:GetAttributeChangedSignal("RolandScythe"):Connect(function() -- Line: 1115
    -- upvalues: u5 (ref)
    if u5 == "Standing" then
        onIdle();

        return;
    end;

    if u5 == "Running" then
        onRunning();
    end;
end);
script_Parent:GetAttributeChangedSignal("RinNoPlay"):Connect(function() -- Line: 1123
    -- upvalues: u5 (ref)
    if u5 == "Standing" then
        onIdle();
    end;
end);
script_Parent:GetAttributeChangedSignal("mobian"):Connect(function() -- Line: 1129
    -- upvalues: u5 (ref)
    if u5 == "Standing" then
        onIdle();
    end;
end);
script_Parent:GetAttributeChangedSignal("DestructiveImpulses"):Connect(function() -- Line: 1136
    -- upvalues: u5 (ref)
    if u5 == "Standing" then
        onIdle();

        return;
    end;

    if u5 == "Running" then
        onRunning();
    end;
end);
script_Parent:GetAttributeChangedSignal("hand_use"):Connect(function() -- Line: 1145
    -- upvalues: actionUtil (copy), LocalPlayer (copy), u5 (ref)
    if actionUtil.checkStyle(LocalPlayer) ~= "akashi" then
        return;
    end;

    if u5 == "Standing" then
        onIdle();

        return;
    end;

    if u5 == "Running" then
        onRunning();
    end;
end);
task.spawn(function() -- Line: 1155
    -- upvalues: ReplicatedStorage (copy), actionUtil (copy), LocalPlayer (copy), u5 (ref)
    local workspace2 = ReplicatedStorage:WaitForChild("workspace", 30);

    if not workspace2 then
        return;
    end;

    local ballHolder = workspace2:WaitForChild("ballHolder", 30);

    if not ballHolder then
        return;
    end;

    ballHolder.Changed:Connect(function() -- Line: 1162
        -- upvalues: actionUtil (ref), LocalPlayer (ref), u5 (ref)
        if actionUtil.checkStyle(LocalPlayer) ~= "akashi" then
            return;
        end;

        if u5 == "Standing" then
            onIdle();

            return;
        end;

        if u5 == "Running" then
            onRunning();
        end;
    end);
end);
script_Parent:GetAttributeChangedSignal("FlowActive"):Connect(function() -- Line: 1173
    -- upvalues: u18 (ref), u5 (ref)
    u18 = 0;

    if u5 == "Standing" then
        onIdle();
    end;
end);
local os_clock_ret = os.clock();

while script_Parent.Parent ~= nil do
    local _, v93 = wait(0.1);
    local os_clock_ret2 = os.clock();
    updateBreakins(os_clock_ret2 - os_clock_ret);
    move(v93);
    os_clock_ret = os_clock_ret2;
end;