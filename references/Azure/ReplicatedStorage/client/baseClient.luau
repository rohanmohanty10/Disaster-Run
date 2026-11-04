 

 

game:GetService("GuiService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local fastSignal = require(ReplicatedStorage:WaitForChild("forum"):WaitForChild("fastSignal"));
local trove = require(ReplicatedStorage:WaitForChild("forum"):WaitForChild("trove"));
local HttpService = game:GetService("HttpService");
local EncodingService = game:GetService("EncodingService");
local u1 = {};
u1.__index = u1;
local actionUtil = require(ReplicatedStorage.util.actionUtil);
local animationUtil = require(ReplicatedStorage.util.animationUtil);
local packets = require(ReplicatedStorage.packets);
require(ReplicatedStorage.query);
require(ReplicatedStorage.util.raycast);
local replication = require(ReplicatedStorage.client.replication);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local GamepadContainer = require(ReplicatedStorage.client.GamepadContainer);
local phainonCoreUI = require(ReplicatedStorage.client.phainonCoreUI);
local u2 = nil;
require(ReplicatedStorage.client.gubbyClient.visibility).start();

local function refreshGubby(p3, p4, p5) -- Line: 30
    -- upvalues: u2 (ref), ReplicatedStorage (copy)
    if not p4:GetAttribute("Gubby") then
        if u2 then
            u2.unbind(p4);
        end;

        return;
    end;

    u2 = u2 or require(ReplicatedStorage.client.gubbyClient);
    u2.bind(p3, p4, p5);
end;

local Volley = ReplicatedStorage.Resources.Volley;
local style = ReplicatedStorage.shared.style;

local function decompile(p6) -- Line: 43
    -- upvalues: EncodingService (copy), HttpService (copy)
    local u7 = EncodingService:DecompressBuffer(EncodingService:Base64Decode((buffer.fromstring(p6))), Enum.CompressionAlgorithm.Zstd);
    local success, result = pcall(function() -- Line: 48
        -- upvalues: HttpService (ref), u7 (ref)
        return HttpService:JSONDecode(buffer.tostring(u7));
    end);

    if success then
        u7 = result;

        for _, v in u7 do
            local v8 = v;

            for i, v2 in v do
                if typeof(v2) == "table" then
                    if i == "Rotation" then
                        v8[i] = CFrame.fromEulerAnglesXYZ(v2[1], v2[2], v2[3]);
                        print("rotation");
                    else
                        v8[i] = Vector3.new(v2[1], v2[2], v2[3]);
                        print("nonrotation");
                    end;
                end;
            end;
        end;
    end;

    return u7;
end;

local workspace_CurrentCamera = workspace.CurrentCamera;
local u9 = {};
local u10 = {};
local u11 = {};

for _, v in Enum.KeyCode:GetEnumItems() do
    if v.Name ~= "Unknown" then
        u9[v.Name] = true;
    end;
end;

for _, v in Enum.UserInputType:GetEnumItems() do
    if v.Name ~= "Unknown" then
        u10[v.Name] = true;
    end;
end;

function u1.new(p12) -- Line: 107
    -- upvalues: u1 (copy), Players (copy), fastSignal (copy)
    local u13 = setmetatable({}, u1);
    local LocalPlayer = Players.LocalPlayer;
    u13.player = LocalPlayer;
    u13.cooldowntable = {};
    u13.moveactived = false;
    u13.kickactived = false;
    u13.starterplayer = p12;
    u13.flowEnded = fastSignal.new();
    u13.playerModule = require(LocalPlayer.PlayerScripts.PlayerModule);

    if LocalPlayer.Character then
        u13:CharacterAdded(LocalPlayer.Character);
    end;

    u13.player.CharacterAdded:connect(function(p14: userdata) -- Line: 121
        -- upvalues: u13 (copy)
        u13:CharacterAdded(p14);
    end);

    return u13;
end;

function u1.createmovement(p15, p16, p17, p18, p19) -- Line: 128
    local Configuration = Instance.new("Configuration");
    Configuration:SetAttribute("speed", p17);
    Configuration:SetAttribute("jump", p18);
    Configuration.Parent = p15.movementFolder;

    if p19 then
        task.delay(p19, Configuration.Destroy, Configuration);
    end;

    return Configuration;
end;

function u1.CharacterAdded(u20, u21) -- Line: 140
    -- upvalues: trove (copy), u2 (ref), ReplicatedStorage (copy), phainonCoreUI (copy), Players (copy), packets (copy)
    if u20.charContainer then
        u20.charContainer:Destroy();
        u20.charContainer = nil;
    end;

    local v22 = u21:WaitForChild("HumanoidRootPart") or u21.PrimaryPart;
    local v23 = u21:FindFirstChildOfClass("Humanoid") or u21:WaitForChild("Humanoid");

    if not u21:FindFirstChild("movements") then
        repeat
            task.wait();
        until u21:FindFirstChild("movements");
    end;

    local movements = u21:FindFirstChild("movements");
    u20.character = u21;
    u20.human = v23;
    u20.humanoidRootPart = v22;

    repeat
        u20.style = u20.player:GetAttribute("style");
        task.wait();
    until u20.style;

    u20.movementFolder = movements;
    local u24 = trove.new();
    u20.charContainer = u24;
    u24:Connect(u21:GetAttributeChangedSignal("Gubby"), function() -- Line: 165
        -- upvalues: u20 (copy), u21 (copy), u24 (copy), u2 (ref), ReplicatedStorage (ref)
        local v25 = u21;

        if not v25:GetAttribute("Gubby") then
            if u2 then
                u2.unbind(v25);
            end;

            return;
        end;

        u2 = u2 or require(ReplicatedStorage.client.gubbyClient);
        u2.bind(u20, v25, u24);
    end);

    if u21:GetAttribute("Gubby") then
        u2 = u2 or require(ReplicatedStorage.client.gubbyClient);
        u2.bind(u20, u21, u24);
    elseif u2 then
        u2.unbind(u21);
    end;

    u24:Connect(u20.player:GetAttributeChangedSignal("style"), function() -- Line: 170
        -- upvalues: u20 (copy), phainonCoreUI (ref), u21 (copy), u24 (copy)
        u20.style = u20.player:GetAttribute("style");

        if u20.style == "phainon" then
            phainonCoreUI.bind(u21, u24);
        end;
    end);

    for _, v in Players:GetPlayers() do
        v.ChildAdded:Connect(function(p26) -- Line: 178
            -- upvalues: v (copy), packets (ref)
            if p26.Name == "DueEmoteParter" and p26.Value == nil then
                local Character = v.Character;

                if not Character then
                    return;
                end;

                local Attribute = p26:GetAttribute("EmoteName");

                if not Attribute then
                    return;
                end;

                if not Character:FindFirstChild("InteractWith") then
                    local ProximityPrompt = Instance.new("ProximityPrompt");
                    ProximityPrompt.Name = "InteractWith";
                    ProximityPrompt.Parent = Character;
                    ProximityPrompt.Activated:Connect(function() -- Line: 192
                        -- upvalues: packets (ref), Attribute (copy), v (ref)
                        packets.emote.send({ Attribute, "Shared", v.Name });
                    end);
                end;
            end;
        end);
    end;

    u24:Add(u21:GetAttributeChangedSignal("FlowActive"):Connect(function() -- Line: 204
        -- upvalues: u21 (copy), u20 (copy)
        if u21:GetAttribute("FlowActive") then
            u20:use("onAwaken", true);

            return;
        end;

        u20:use("onAwakeEnded", true);
        u20.flowEnded:Fire();
    end));

    if u20.style == "phainon" then
        phainonCoreUI.bind(u21, u24);
    end;
end;

function u1.findCooldown(p27, p28) -- Line: 218
    return p27.cooldowntable[p28] ~= nil;
end;

function u1.addCooldown(u29, u30, p31, p32) -- Line: 222
    -- upvalues: replication (copy)
    if u29:findCooldown(u30) then
        return;
    end;

    u29.cooldowntable[u30] = true;

    if p32 then
        task.spawn(replication.cooldown, u30, p31);
    end;

    task.delay(p31, function() -- Line: 232
        -- upvalues: u29 (copy), u30 (copy)
        u29.cooldowntable[u30] = nil;
    end);
end;

function u1.removeCooldown(p33, p34) -- Line: 237
    if not p33:findCooldown(p34) then
        return;
    end;

    p33.cooldowntable[p34] = nil;
end;

function u1.use(p35, p36, p37) -- Line: 244
    -- upvalues: Players (copy), actionUtil (copy), style (copy)
    if p35.character and p35.character:GetAttribute("Gubby") then
        if p36 == "Tspecialer" then
            p35:senduse({ "Tspecialer" });

            return;
        end;

        if p35.character:GetAttribute("GubbyGunEquipped") then
            return;
        end;
    end;

    if Players.LocalPlayer:GetAttribute("BeingControlledBy") then
        return;
    end;

    if p35.character and p35.character:GetAttribute("InMarble") then
        return;
    end;

    if p35.is_volley then
        return;
    end;

    local style2 = p35.style;
    local MoveInfoForRandomized, v38 = actionUtil.getMoveInfoForRandomized(actionUtil.getRandomized(p35.player, p36));

    if MoveInfoForRandomized and v38 then
        p36 = MoveInfoForRandomized[1];
    else
        v38 = style2;
    end;

    local v39 = p35.character:GetAttribute("NoFreeze") and true or p37;
    local v40 = p35.character:GetAttribute("canReuse") and p35.character:GetAttribute("canReuse") == p36 and true or v39;
    local v41 = p36 == "skill2" and p35.character:GetAttribute("DancePartyPassReady") and true or v40;
    local v42 = p36 == "dash" and (p35.character:GetAttribute("windmillshot") or p35.character:GetAttribute("KaiserMagnus")) and true or v41;
    local v43 = p36 == "skill3" and (p35.style == "aizen" and p35.character:GetAttribute("AizenGoryuWindup")) and true or v42;

    if p36 == "Tspecialer" then
        if actionUtil.checkGK(p35.character) then
            return;
        end;

        v43 = true;
    end;

    local v44 = v38 == "sae" and p36 == "baseAwaken" and true or v43;
    local v45 = style:FindFirstChild(v38) and require(style[v38]);
    local v46 = v45 and v45.statemachine and v45.statemachine(p35, p36);

    if v46 == Enum.TriStateBoolean.True then
        v44 = true;
    elseif v46 == Enum.TriStateBoolean.False then
        return;
    end;

    if not v44 then
        if p35:findCooldown(p36) or p35.moveactived then
            return;
        end;

        if actionUtil.statecheck(p35.character) and not table.find(v45 and v45.bufferable or {}, p36) then
            return;
        end;
    end;

    local v47 = script:FindFirstChild(v38);

    if v47 then
        local v48 = require(v47);

        if v48[p36] then
            task.spawn(v48[p36], p35);

            return;
        end;
    end;

    task.spawn(p35[p36], p35);
end;

function u1.senduse(p49, p50) -- Line: 335
    -- upvalues: Players (copy), packets (copy)
    if Players.LocalPlayer:GetAttribute("BeingControlledBy") then
        return;
    end;

    packets.bytenet_use.send(p50);
end;

function u1.gkfocus(p51) -- Line: 343
    -- upvalues: actionUtil (copy), replication (copy), UserInputService (copy)
    if not actionUtil.checkGK(p51.character) then
        return;
    end;

    local v52 = p51:createmovement(p51.character, 11);
    replication.fov(true, 60, 0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);

    while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) and not actionUtil.statecheck(p51.character) do
        task.wait();
    end;

    replication.fov(true, 70, 0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    v52:Destroy();
end;

function u1.givmeBall(p53) -- Line: 362
    p53:senduse({ "givmeBall" });
end;

function u1.Tspecialer(p54) -- Line: 366
    p54:senduse({ "Tspecialer" });
end;

function u1.superDash(p55) -- Line: 370
    -- upvalues: actionUtil (copy)
    if actionUtil.checkGK(p55.character) then
        p55:addCooldown("tackle", 1, true);
    end;

    p55:senduse({ "run" });
end;

function u1.throwGoal(p56) -- Line: 377
    p56:senduse({ "throwGoal" });
end;

function u1.onAwaken(p57) -- Line: 381
end;

function u1.onAwakeEnded(p58) -- Line: 382
end;

function u1.skill1(p59) -- Line: 384
    p59:senduse({ "skill1" });
end;

function u1.skill2(p60) -- Line: 388
    p60:senduse({ "skill2" });
end;

function u1.skill3(p61) -- Line: 392
    p61:senduse({ "skill3" });
end;

function u1.skill4(p62) -- Line: 396
    p62:senduse({ "skill4" });
end;

function u1.skill5(p63) -- Line: 400
    p63:senduse({ "skill5" });
end;

function u1.baseAwaken(p64) -- Line: 406
    p64:senduse({ "baseAwaken" });
end;

function u1.jump(u65) -- Line: 410
    -- upvalues: actionUtil (copy), animationUtil (copy), ReplicatedStorage (copy), soundUtil (copy)
    local PlayerFromCharacter = game.Players:GetPlayerFromCharacter(u65.character);

    if PlayerFromCharacter and PlayerFromCharacter.UserId == 3928166028 then
        return;
    end;

    if not actionUtil.checkball(u65.character) then
        return;
    end;

    local table_find_ret = table.find({ "Release", "v1.3", "1.5" }, actionUtil.checkReleaseStyle(u65.character));
    u65:addCooldown("jump", 2, true);
    local v66 = animationUtil:loadAnimation(u65.character, ReplicatedStorage.Resources[table_find_ret and "oldjumpserv" or "jumpserv"]);
    v66:Play();
    soundUtil:play(ReplicatedStorage.Resources["jump" .. Random.new():NextInteger(1, 3)], u65.humanoidRootPart);
    local LookVector = u65.humanoidRootPart.CFrame.LookVector;
    local Unit = Vector3.new(LookVector.X, table_find_ret and 0.55 or 0.7, LookVector.Z).Unit;

    if table_find_ret then
        v66:GetMarkerReachedSignal("hit"):Once(function() -- Line: 429
            -- upvalues: u65 (copy), Unit (copy)
            u65:senduse({
                "kick",
                8,
                nil,
                Unit,
                true
            });
        end);
        v66.Stopped:Wait();

        return;
    end;

    task.wait(0.15);

    if not PlayerFromCharacter.Character:GetAttribute("frozen") then
        u65:senduse({
            "kick",
            29.85,
            nil,
            Unit,
            true
        });
    end;
end;

function u1.Volley(u67) -- Line: 442
    -- upvalues: ReplicatedStorage (copy), actionUtil (copy), Volley (copy), u11 (copy), animationUtil (copy), replication (copy), soundUtil (copy), RunService (copy)
    if u67.character:GetAttribute("SaeStepoverFirstPart") or u67.character:GetAttribute("InMarble") then
        return;
    end;

    if u67.is_volley then
        return;
    end;

    local CFBall = ReplicatedStorage:FindFirstChild("CFBall");
    local v68 = nil;
    local v69 = actionUtil.ballHolder();
    local v70;

    if CFBall then
        v70 = CFBall.Value.Position;
    else
        v70 = nil;
    end;

    if not v70 and v69 then
        v68 = v69:GetPivot().Position;
        v70 = v68;
    end;

    local v71;

    if v68 then
        v71 = v69;
    else
        v71 = actionUtil.getworkspace().holderBefore.Value;

        if v71 then
            v68 = v71:GetPivot().Position;
        else
            v71 = v69;
        end;
    end;

    if not v70 then
        return;
    end;

    if v68 and (v71 and (not actionUtil.checksameTeam(u67.character, v71) and (v68 - u67.humanoidRootPart.Position).Magnitude < 15)) then
        return;
    end;

    local character = u67.character;
    local _ = u67.human;
    local PlayerControl = character:WaitForChild("PlayerControl");
    local Pivot = character:GetPivot();
    local _ = (workspace.CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit:Cross(Vector3.new(0, 1, 0)).Unit;
    local v72 = nil;
    local v73 = nil;
    local v74 = Pivot.RightVector:Dot((v70 - Pivot.Position).Unit);
    local v75 = v74 > 0.05;
    local v76 = {};

    if v75 or not v75 and v74 < -0.05 then
        local v77 = v70.Y > 4.050000000000001;
        local v78 = v75 and "Right" or "Left";
        local v79 = v75 and "Left" or "Right";
        local v80 = v77 and "Up" or "Low";
        local v81 = v77 and "Low" or "Up";
        local v82 = Volley[`{v80}{v78}`];
        table.insert(v76, v82);
        local v83 = Volley[`{v81}{v78}`];
        table.insert(v76, v83);
        table.insert(v76, Volley.UpForward);
        table.insert(v76, Volley.LowForward);
        local v84 = Volley[`{v80}{v79}`];
        table.insert(v76, v84);
        local v85 = Volley[`{v81}{v79}`];
        table.insert(v76, v85);
    else
        local v86 = v70.Y > 2.0500000000000003;
        local v87 = v74 > 0 and "Right" or "Left";
        local v88 = v74 > 0 and "Left" or "Right";
        local v89 = v86 and "Up" or "Low";
        local v90 = v86 and "Low" or "Up";
        table.insert(v76, Volley.UpForward);
        table.insert(v76, Volley.LowForward);
        local v91 = Volley[`{v89}{v87}`];
        table.insert(v76, v91);
        local v92 = Volley[`{v90}{v87}`];
        table.insert(v76, v92);
        local v93 = Volley[`{v89}{v88}`];
        table.insert(v76, v93);
        local v94 = Volley[`{v90}{v88}`];
        table.insert(v76, v94);
    end;

    local v95 = (1 / 0);

    for _, v in v76 do
        local Attribute = v:GetAttribute("Offset");
        local math_abs_ret = math.abs(v70.Y - (Attribute.Y + 3.0500000000000003));

        if math_abs_ret < v95 then
            v73 = v;
            v95 = math_abs_ret;
        end;
    end;

    if not v73 then
        return;
    end;

    local u96 = ReplicatedStorage.Resources.volleySFX[v73:GetAttribute("Sound")];
    local v97 = u11[v73];

    if not v97 then
        v72 = animationUtil:loadAnimation(character, v73);

        while v72.Length <= 0 do
            task.wait();
        end;

        v97 = v72:GetTimeOfKeyframe("Kick");
        u11[v73] = v97;
    end;

    local u98 = v97 / 1;

    if not actionUtil.statecheck(character) then
        local u99 = v72 or animationUtil:loadAnimation(character, v73);
        local u100 = newproxy();
        u67.is_volley = u100;
        task.spawn(function() -- Line: 571
            -- upvalues: actionUtil (ref), character (copy), u67 (copy), PlayerControl (copy), replication (ref), u99 (ref), soundUtil (ref), u96 (ref), u98 (ref), ReplicatedStorage (ref), RunService (ref)
            local function _() -- Line: 572
                -- upvalues: actionUtil (ref), character (ref), u67 (ref)
                local v101 = actionUtil.checkball(character) or actionUtil.statecheck(character) and not actionUtil.isTackling(u67.character);

                return v101;
            end;

            local v102 = actionUtil.checkball(character) or actionUtil.statecheck(character) and not actionUtil.isTackling(u67.character);

            if v102 then
                u67.is_volley = false;

                return;
            end;

            character:SetAttribute("cantgetball", true);
            PlayerControl.Value = false;
            character:SetAttribute("disableRotate", true);
            character:SetAttribute("ForceSmoothShiftlock", true);
            u67.human.AutoRotate = true;
            replication.destroyVelocity(u67.character);
            local v103 = actionUtil.checkball(character) or actionUtil.statecheck(character) and not actionUtil.isTackling(u67.character);
            local v104;

            if v103 then
                v104 = 0;
            else
                u99.Priority = Enum.AnimationPriority.Action4;
                u99:Play(0.1, 1, 1);
                soundUtil:play(u96, u67.humanoidRootPart);
                character:SetAttribute("disableRotate", false);
                v104 = u98 / 1;
                replication.fov(true, 45, v104, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
                soundUtil:play(ReplicatedStorage.Resources.volleySFX["zoom in"], u67.humanoidRootPart);
            end;

            while not v103 and v104 > 0 do
                local v105 = RunService.Heartbeat:Wait();
                v103 = actionUtil.checkball(character) or actionUtil.statecheck(character) and not actionUtil.isTackling(u67.character);
                v104 = v104 - v105;
            end;

            if v103 then
                u99:Stop(0.3);
            else
                local CFBall2 = ReplicatedStorage:FindFirstChild("CFBall");

                if CFBall2 then
                    local Value = CFBall2.velocity.Value;
                    local buffer_create_ret = buffer.create(1);
                    local math_clamp_ret = math.clamp(Value.Magnitude * 3, 50, 110);
                    buffer.writei8(buffer_create_ret, 0, math_clamp_ret);
                    u67:senduse({ "volley", false, buffer_create_ret });
                end;
            end;

            replication.fov(true, 70, 0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);

            if v103 then
                u99:Stop(0.2);
            else
                local v106 = (u99.Length - u99.TimePosition) / 1;

                while not v103 and v106 > 0 do
                    local v107 = RunService.Heartbeat:Wait();
                    v103 = actionUtil.checkball(character);
                    v106 = v106 - v107;
                end;
            end;

            character:SetAttribute("cantgetball", false);
            u67.is_volley = false;
            PlayerControl.Value = true;
            task.wait(0.5);
            character:SetAttribute("ForceSmoothShiftlock", false);
        end);

        if u67.is_volley then
            task.delay(4, function() -- Line: 646
                -- upvalues: u67 (copy), u100 (copy)
                if u67.is_volley == u100 then
                    u67.is_volley = false;
                end;
            end);
        end;

        return u67.is_volley;
    end;
end;

function u1.get_target(p108, p109) -- Line: 655
    -- upvalues: u9 (copy), u10 (copy)
    return u9[p109] ~= nil and Enum.KeyCode[p109] or u10[p109] and Enum.UserInputType[p109];
end;

function u1.kick(u110) -- Line: 659
    -- upvalues: actionUtil (copy), UserInputService (copy), soundUtil (copy), ReplicatedStorage (copy), animationUtil (copy), u9 (copy), u10 (copy), GamepadContainer (copy), TweenService (copy), replication (copy), workspace_CurrentCamera (copy)
    local PlayerFromCharacter = game.Players:GetPlayerFromCharacter(u110.character);

    if u110.is_volley or u110.character and u110.character:GetAttribute("InMarble") then
        return;
    end;

    if u110.character:GetAttribute("SaeStepoverFirstPart") then
        return;
    end;

    local table_find_ret = table.find({ "Release", "v1.3" }, actionUtil.checkReleaseStyle(u110.character));
    local setting = u110.player:FindFirstChild("setting");

    if not setting then
        return;
    end;

    if not table_find_ret then
        local state = u110.character:FindFirstChild("state");

        if not state then
            return;
        end;

        local v111 = setting.autoHeader.Value or state.mode.Value == "Techniques";

        if setting.volleys.Value then
            local LastInputType = UserInputService:GetLastInputType();
            local v112 = false;

            for _, v in UserInputService:GetMouseButtonsPressed() do
                if v.UserInputType == Enum.UserInputType.MouseButton2 then
                    v112 = true;
                    break;
                end;
            end;

            if v111 and ((LastInputType.Name:match("Gamepad") and UserInputService:IsGamepadButtonDown(LastInputType, Enum.KeyCode.ButtonL3) and true or v112) and (u110.playerModule:GetCameras().activeMouseLockController.isMouseLocked and u110:Volley())) then
                u110.kickactived = false;

                return;
            end;
        end;
    end;

    if u110.character:GetAttribute("noM1kick") then
        return;
    end;

    if u110.kickactived then
        return;
    end;

    u110.kickactived = true;
    soundUtil:play(ReplicatedStorage.Resources["charge shot"], u110.humanoidRootPart);
    local v113 = animationUtil:loadAnimation(u110.character, ReplicatedStorage.Resources[table_find_ret and "oldkick" or "kick"]);
    v113:Play();
    v113:AdjustSpeed(table_find_ret and 0 or 2.5);
    local v114 = u110:createmovement(u110.character, 11);
    local os_clock_ret = os.clock();
    local v115 = false;
    local v116 = PlayerFromCharacter and PlayerFromCharacter.UserId ~= 3928166028 and 200 or 250;
    local v117 = table_find_ret and 20 or 0;
    local v118 = table_find_ret and 70 or 50;
    local _ = UserInputService.TouchEnabled;
    local u119 = true;
    local Value = setting.customKeybinds.kick.Value;
    local u120 = u9[Value] ~= nil and Enum.KeyCode[Value];

    if not u120 then
        if u10[Value] == nil then
            u120 = false;
        else
            u120 = Enum.UserInputType[Value];
        end;
    end;

    local KeyCode = GamepadContainer[6].KeyCode;
    local v123 = UserInputService.InputEnded:Connect(function(p121, p122) -- Line: 740
        -- upvalues: u110 (copy), u119 (ref), UserInputService (ref), KeyCode (copy), u10 (ref), Value (copy), u120 (copy), u9 (ref)
        if p121.UserInputType.Name == "Touch" and not u110.starterplayer.inputs.KickButton then
            u119 = false;
        end;

        if p121.UserInputType.Name:match("Gamepad") and not UserInputService:IsGamepadButtonDown(p121.UserInputType, KeyCode) then
            u119 = false;
        end;

        if p121.UserInputType.Name:match("MouseButton") and (u10[Value] and not UserInputService:IsMouseButtonPressed(u120)) then
            u119 = false;
        end;

        if p121.UserInputType.Name == "Keyboard" and (u9[Value] and not UserInputService:IsKeyDown(u120)) then
            u119 = false;
        end;
    end);
    local v124 = v118 / 2;
    local v125 = {};

    while u119 and not (u110.moveactived or actionUtil.statecheck(u110.character)) do
        local v126 = table_find_ret and 10 or task.wait();
        local v127;

        if table_find_ret then
            v127 = os.clock() - os_clock_ret or v116;
        else
            v127 = v116;
        end;

        if not u110.kickactived then
            break;
        end;

        if u110.character and (u110.character:GetAttribute("KuronaBenefits") and v124 <= v117) then
            for _, child in workspace.characters:GetChildren() do
                if child ~= u110.character and (child:FindFirstChild("HumanoidRootPart") and (u110.humanoidRootPart and (actionUtil.checksameTeam(u110.character, child) and ((u110.humanoidRootPart.Position - child.HumanoidRootPart.Position).Magnitude <= 107.5 and not v125[child])))) then
                    local Highlight = Instance.new("Highlight");
                    Highlight.OutlineColor = Color3.fromRGB(255, 0, 255);
                    Highlight.FillTransparency = 1;
                    Highlight.OutlineTransparency = 1;
                    Highlight.FillColor = Color3.fromRGB(255, 0, 127);
                    Highlight.Parent = child;
                    v125[child] = Highlight;
                    TweenService:Create(Highlight, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                        FillTransparency = 0.5,
                        OutlineTransparency = 0
                    }):Play();
                end;
            end;

            for i, v in v125 do
                if i ~= u110.character and (i:FindFirstChild("HumanoidRootPart") and (u110.humanoidRootPart and (u110.humanoidRootPart.Position - i.HumanoidRootPart.Position).Magnitude > 107.5)) then
                    pcall(game.Destroy, v);
                    v125[i] = nil;
                end;
            end;
        end;

        if u110.dashactived then
            v117 = 0;
        else
            v117 = math.clamp(v117 + v127 * v126, 0, v118);

            if v118 <= v117 and not v115 then
                v115 = true;
                soundUtil:play(ReplicatedStorage.Resources.charges, u110.humanoidRootPart);
                soundUtil:play(ReplicatedStorage.Resources["charge shot ball charging"], u110.humanoidRootPart);
                replication.Emit(u110.humanoidRootPart, ReplicatedStorage.Resources.full, 2);

                if table_find_ret then
                    replication.raycastEffect(u110.humanoidRootPart, ReplicatedStorage.Resources.ForwardSmoke);
                else
                    v113:AdjustSpeed(0);
                    replication.Emit(u110.humanoidRootPart, ReplicatedStorage.Resources.JumpEffect, 3, CFrame.new(0, -3, 0));
                end;

                replication.cameraShake(table_find_ret and 15 or 20, table_find_ret and 0.8 or 0.3, 2);
                replication.highlight(u110.character, Color3.fromRGB(255, 255, 255), 1);
            end;
        end;
    end;

    for _, v in v125 do
        pcall(game.Destroy, v);
    end;

    if v123 then
        v123:Disconnect();
    end;

    v114:Destroy();
    v113:AdjustSpeed(1);

    if not table_find_ret then
        v113:Stop(0);

        if not u110.kickactived or (u110.character:GetAttribute("noM1kick") or actionUtil.statecheck(u110.character) and not actionUtil.isTackling(u110.character)) then
            u110.kickactived = false;

            return;
        end;

        animationUtil:loadAnimation(u110.character, ReplicatedStorage.Resources.kick2):Play(0);
    end;

    local LookVector = u110.humanoidRootPart.CFrame.LookVector;
    local X = LookVector.X;
    local math_clamp_ret = math.clamp(workspace_CurrentCamera.CFrame.LookVector.Y, -1, 1);
    local Unit = Vector3.new(X, math_clamp_ret, LookVector.Z).Unit;
    soundUtil:play(ReplicatedStorage.Resources["charge shot swing"], u110.humanoidRootPart);
    local v128 = u110.humanoidRootPart.CFrame:VectorToObjectSpace(u110.human.MoveDirection);
    local v129 = math.round(v128.X) == 1;
    local v130 = math.round(v128.X) == -1;

    if not u110.character:GetAttribute("Gubby") then
        task.wait(0.15);
    end;

    local v131, v132;

    if u110.character:GetAttribute("KuronaBenefits") then
        local Mouse = PlayerFromCharacter:GetMouse();
        local v133 = (UserInputService.GamepadEnabled or UserInputService.TouchEnabled) and Vector2.new(workspace_CurrentCamera.ViewportSize.X / 2, workspace_CurrentCamera.ViewportSize.Y / 2) or Vector2.new(Mouse.X, Mouse.Y);
        v131 = nil;
        local v134 = nil;
        v132 = true;

        for _, child in pairs(workspace.characters:GetChildren()) do
            if not table.find({ child }, u110.character) then
                local HumanoidRootPart = child:FindFirstChild("HumanoidRootPart");

                if child:FindFirstChildOfClass("Humanoid").Health > 0 and (HumanoidRootPart and (actionUtil.checksameTeam(u110.character, child) and (HumanoidRootPart.Position - u110.humanoidRootPart.Position).magnitude < 107.5)) then
                    local v135, v136 = workspace_CurrentCamera:WorldToScreenPoint(HumanoidRootPart.Position);
                    local Vector2_new_ret = Vector2.new(v135.X, v135.Y);

                    if v136 then
                        local magnitude = (v133 - Vector2_new_ret).magnitude;

                        if v131 and v134 then
                            if magnitude < v134 then
                                v134 = magnitude;
                                v131 = child;
                            end;
                        else
                            v134 = magnitude;
                            v131 = child;
                        end;
                    end;
                end;
            end;
        end;
    else
        v132 = false;
        v131 = nil;
    end;

    u110:senduse({
        "kick",
        v118 <= v117 and 95 or (v117 > 25 and (table_find_ret and 35 or 40) or 29),
        v130 and "left" or v129,
        Unit,
        (v124 > v117 or not (v132 and v131)) and "basicShot" or v131
    });
    v113.Priority = Enum.AnimationPriority.Action;
    u110.kickactived = false;
end;

function u1.drib(p137) -- Line: 938
    -- upvalues: actionUtil (copy)
    game.Players:GetPlayerFromCharacter(p137.character);

    if p137.is_volley then
        return;
    end;

    if not actionUtil.checkball(p137.character) then
        return;
    end;

    local X = p137.humanoidRootPart.CFrame:VectorToObjectSpace(p137.human.MoveDirection).X;
    p137:senduse({ "dribble", math.round(X) == -1 });
end;

function u1.modetoggle(p138) -- Line: 952
    -- upvalues: actionUtil (copy)
    local PlayerFromCharacter = game.Players:GetPlayerFromCharacter(p138.character);
    local setting = p138.player:FindFirstChild("setting");

    if not setting then
        return;
    end;

    local Value = setting.customKeybinds.modetoggle.Value;

    if Enum.KeyCode[Value or "E"] and (Enum.KeyCode[Value or "E"] == Enum.KeyCode.E and actionUtil.checkball(p138.character)) then
        return;
    end;

    if PlayerFromCharacter and PlayerFromCharacter.UserId ~= 3928166028 then
        p138:senduse({ "changeMode" });
    end;
end;

function u1.dash(u139) -- Line: 970
    -- upvalues: actionUtil (copy), ReplicatedStorage (copy), animationUtil (copy), soundUtil (copy), replication (copy), RunService (copy), TweenService (copy)
    if u139.is_volley or u139.character and u139.character:GetAttribute("InMarble") then
        return;
    end;

    if not ((u139.character:GetAttribute("windmillshot") or u139.character:GetAttribute("KaiserMagnus")) and actionUtil.statecheck(u139.character, { "actived" })) and actionUtil.statecheck(u139.character) then
        return;
    end;

    if u139.character:GetAttribute("nobasedash") then
        return;
    end;

    local table_find_ret = table.find({ "Release", "v1.3", "v1.5" }, actionUtil.checkReleaseStyle(u139.character));
    local v140 = u139.humanoidRootPart.CFrame:VectorToObjectSpace(u139.human.MoveDirection);
    local v141 = math.round(v140.X) == -1 or math.round(v140.X) == 1;
    local u142 = math.round(v140.X) == -1;
    local _ = math.round(v140.Z) == 1;
    local v143 = actionUtil.checkGK(u139.character);
    local workspace2 = ReplicatedStorage:WaitForChild("workspace");
    local u144 = u139.character:GetAttribute("legacygk") and v143;
    local v145 = v143 and 0.85 or 0.655;
    u139.dashactived = true;
    task.delay(v143 and (u144 and 0.805 or 1) or 0.35, function() -- Line: 993
        -- upvalues: u144 (copy), u139 (copy)
        if u144 then
            u139:senduse({ "sidedashoffset" });
        end;

        u139.dashactived = false;
    end);

    if v143 then
        if actionUtil.checkball(u139.character) then
            return;
        end;

        if not v141 then
            if u139.is_volley then
                return;
            end;

            u139:senduse({ "tackle" });

            return;
        end;

        if u144 then
            animationUtil:loadAnimation(u139.character, u142 and ReplicatedStorage.Resources.goalLeftL or ReplicatedStorage.Resources.goalRightL):Play();
            soundUtil:play(ReplicatedStorage.Resources[u142 and "jumpgrab" or "rightgrab"], u139.humanoidRootPart);
            local u146, u147 = replication.bodyVelocity(u139.humanoidRootPart, 110, 0.3, nil, nil, true, TweenInfo.new(0.44999999999999996, Enum.EasingStyle.Linear, Enum.EasingDirection.Out));
            u146.MaxForce = Vector3.new(30000, 30000, 30000);
            u139:senduse({ "sidedashoffset", u142 });
            local u148 = nil;
            u148 = RunService.PreRender:connect(function(p149) -- Line: 1028
                -- upvalues: u146 (copy), u148 (ref), u142 (copy), u139 (copy), u147 (copy)
                if not u146:IsDescendantOf(game) then
                    u148:Disconnect();

                    return;
                end;

                if u142 then
                    u146.Velocity = u139.humanoidRootPart.CFrame.RightVector * -u147.Value + u139.humanoidRootPart.CFrame.UpVector * 5;

                    return;
                end;

                u146.Velocity = u139.humanoidRootPart.CFrame.RightVector * u147.Value + u139.humanoidRootPart.CFrame.UpVector * 5;
            end);
            local u150 = nil;
            u150 = workspace2.ballHolder.Changed:connect(function() -- Line: 1043
                -- upvalues: actionUtil (ref), u139 (copy), u150 (ref), animationUtil (ref), ReplicatedStorage (ref), u142 (copy), replication (ref)
                if not actionUtil.checkball(u139.character) then
                    return;
                end;

                u150:Disconnect();
                animationUtil:loadAnimation(u139.character, ReplicatedStorage.Resources.gkAssets[u142 and "hitBallL" or "hitBallR"]):Play(0);
                replication.gkHitBallDash(u139.character);
            end);
            task.delay(0.55, u150.Disconnect, u150);
            local v151 = u139:createmovement(u139.character, nil, 0);
            task.delay(0.3, v151.Destroy, v151);
        else
            local u152 = nil;
            local v153 = u139:createmovement(u139.character, 11, 0);
            animationUtil:loadAnimation(u139.character, u142 and ReplicatedStorage.Resources.gkAssets.DashL or ReplicatedStorage.Resources.gkAssets.DashR):Play();
            u152 = workspace2.ballHolder.Changed:connect(function() -- Line: 1069
                -- upvalues: actionUtil (ref), u139 (copy), u152 (ref), animationUtil (ref), ReplicatedStorage (ref), u142 (copy), replication (ref)
                if not actionUtil.checkball(u139.character) then
                    return;
                end;

                u152:Disconnect();
                animationUtil:loadAnimation(u139.character, ReplicatedStorage.Resources.gkAssets[u142 and "hitBallL" or "hitBallR"]):Play(0);
                replication.gkHitBallDash(u139.character);
            end);
            task.delay(0.55, u152.Disconnect, u152);
            task.delay(v145, v153.Destroy, v153);
        end;
    else
        if not v141 then
            u139:senduse({ "tackle" });

            return;
        end;

        if (u139:findCooldown("Side Dash") or u139.character:GetAttribute("ShidouDraconic")) and not (u139.character:GetAttribute("windmillshot") or u139.character:GetAttribute("KaiserMagnus")) then
            return;
        end;

        if not (u139.character:GetAttribute("windmillshot") or u139.character:GetAttribute("KaiserMagnus")) then
            u139:addCooldown("Side Dash", 2, true);
        end;

        if u139.character:GetAttribute("ShidouDraconic") then
            return;
        end;

        u139:senduse({ "sidedash", u142 });
        local character = u139.character;
        local v154;

        if u139.character:GetAttribute("Gubby") then
            v154 = ReplicatedStorage.client.gubbyClient.Animations[u142 and "DashL" or "DashR"];
        else
            v154 = u142 and ReplicatedStorage.Resources.dashL or ReplicatedStorage.Resources.dashR;
        end;

        animationUtil:loadAnimation(character, v154):Play();
        soundUtil:play(ReplicatedStorage.Resources[`Side dash {Random.new():NextInteger(1, 2)}`], u139.humanoidRootPart);

        if table_find_ret then
            local BodyPosition = Instance.new("BodyPosition");
            BodyPosition.P = 12500;
            BodyPosition.MaxForce = Vector3.new(30000, 0, 30000);
            BodyPosition.D = 300;
            BodyPosition.Parent = u139.humanoidRootPart;
            TweenService:Create(BodyPosition, TweenInfo.new(v145, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                P = 2500,
                D = 500
            }):Play();
            local v156 = RunService.PreRender:Connect(function(p155) -- Line: 1119
                -- upvalues: u142 (copy), BodyPosition (copy), u139 (copy)
                if u142 then
                    BodyPosition.Position = -u139.humanoidRootPart.CFrame.RightVector * 3 + u139.humanoidRootPart.Position;

                    return;
                end;

                BodyPosition.Position = u139.humanoidRootPart.CFrame.RightVector * 3 + u139.humanoidRootPart.Position;
            end);
            task.delay(v145, BodyPosition.Destroy, BodyPosition);
            task.delay(v145, v156.Disconnect, v156);
        end;
    end;

    u139:addCooldown("dash", v145);

    if not table_find_ret or v143 then
        replication.dash(u139.character, v143, u142);
    end;
end;

function u1.IsSettingOn(p157, p158) -- Line: 1137
    local player = p157.player;
    local v159 = false;

    if player:FindFirstChild("setting") and (not v159 and player.setting:FindFirstChild(p158)) then
        v159 = player.setting:FindFirstChild(p158).Value;
    end;

    return v159;
end;

u1.removecooldown = u1.removeCooldown;
u1.addcooldown = u1.addCooldown;
u1.findcooldown = u1.findCooldown;

return u1;