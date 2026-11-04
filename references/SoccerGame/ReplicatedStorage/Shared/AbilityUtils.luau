  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerScriptService = game:GetService("ServerScriptService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
local Teams = game:GetService("Teams");
local Debris = game:GetService("Debris");
game:GetService("StarterPlayer");
local HttpService = game:GetService("HttpService");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local FindCurveDirection = require(ReplicatedStorage.Shared.utils.FindCurveDirection);
local LocalPlayer = Players.LocalPlayer;
local getCharacter = require(ReplicatedStorage.Shared.utils.getCharacter);
local u6 = {
    getCharacter = getCharacter,
    execute = {
        dash = require(script.executeDash),
        shot = require(script.executeShot).executeShot,
        doShot = require(script.executeShot).doShot,
        shotServer = require(script.executeShotServer)
    },
    rules = {},
    checks = {},

    findAirBallAboveCharacter = function(p1: userdata?, p2: number?, p3: number?, p4: number?) -- Line: 37, Name: findAirBallAboveCharacter
        -- upvalues: ReplicatedStorage (copy)
        if p1 then
            p1 = p1:FindFirstChild("HumanoidRootPart");
        end;

        local Football = ReplicatedStorage:FindFirstChild("Football");

        if Football then
            Football = Football.Value;
        end;

        if not (p1 and (p1:IsA("BasePart") and (Football and (Football:IsA("BasePart") and (Football.Parent == workspace and not Football.Anchored))))) then
            return nil;
        end;

        local OnPlayer = Football:FindFirstChild("OnPlayer");

        if OnPlayer and OnPlayer.Value then
            return nil;
        end;

        local v5 = Football.Position - p1.Position;
        local Magnitude = Vector3.new(v5.X, 0, v5.Z).Magnitude;

        if v5.Y < (p3 or 5) or ((p4 or 35) < v5.Y or (p2 or 25) < Magnitude) then
            return nil;
        end;

        return Football;
    end
};

function u6.rules.onball(p7: userdata?, p8: boolean?) -- Line: 75
    -- upvalues: getCharacter (copy), Popup (copy)
    local v9, _, _, v10 = getCharacter(p7);

    if v9 and v10.HasBall.Value then
        return true;
    end;

    if p8 ~= false then
        Popup.Popup(p7, "Must have the ball!");
    end;

    return false;
end;

function u6.rules.offball(p11: userdata?, p12: boolean?) -- Line: 86
    -- upvalues: getCharacter (copy), Popup (copy)
    local v13, _, _, v14 = getCharacter(p11);

    if v13 and not v14.HasBall.Value then
        return true;
    end;

    if p12 ~= false then
        Popup.Popup(p11, "Must not have the ball!");
    end;

    return false;
end;

function u6.rules.airBall(p15: userdata, p16: number?, p17: number?, p18: boolean?) -- Line: 97
    -- upvalues: getCharacter (copy), ReplicatedStorage (copy), Popup (copy)
    local v19 = p16 or 30;
    local _, v20, _, _ = getCharacter(p15);
    local Value = ReplicatedStorage.Football.Value;
    local Value2 = Value.Char.Value;

    if Value2 and (Value2.Values.Goalie.Value and Value2.Values.IsInPenalty.Value == true) then
        if p18 ~= false then
            Popup.Popup(p15, "Ball was just thrown by the goal keeper");
        end;

        return false;
    end;

    if not (Value and (Value.Parent == workspace and (not v19 or v19 >= (v20.Position - Value.Position).Magnitude))) then
        if p18 ~= false then
            Popup.Popup(p15, "Ball must be loose and within range! (" .. v19 .. ")");
        end;

        return false;
    end;

    if Value.Position.Y >= 14 then
        return true;
    end;

    if p18 ~= false then
        Popup.Popup(p15, "Ball not in the air!");
    end;

    return false;
end;

function u6.findBallHolderInRange(p21: userdata, p22: number) -- Line: 136
    -- upvalues: Players (copy), Teams (copy)
    if not (p21 and p21:FindFirstChild("HumanoidRootPart")) then
        return nil;
    end;

    local Position = p21.HumanoidRootPart.Position;
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(p21);

    for _, v in Players:GetPlayers() do
        if v.Character ~= p21 and (v.Team ~= Teams:FindFirstChild("Visitor") and (not PlayerFromCharacter or v.Team ~= PlayerFromCharacter.Team)) and (v.Character and (v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Values"))) then
            local HasBall = v.Character.Values:FindFirstChild("HasBall");

            if HasBall and HasBall.Value then
                local Goalie = v.Character.Values:FindFirstChild("Goalie");
                local IsInPenalty = v.Character.Values:FindFirstChild("IsInPenalty");

                if not (Goalie and (Goalie.Value and (IsInPenalty and IsInPenalty.Value))) and p22 >= (v.Character.HumanoidRootPart.Position - Position).Magnitude then
                    return v.Character;
                end;
            end;
        end;
    end;

    local PassRig = workspace:FindFirstChild("PassRig");

    if PassRig and PassRig:GetAttribute("IsTrainingDummy") then
        local HumanoidRootPart = PassRig:FindFirstChild("HumanoidRootPart");

        if HumanoidRootPart and (HumanoidRootPart.Position - Position).Magnitude <= p22 then
            return PassRig;
        end;
    end;

    return nil;
end;

function u6.findAikuAwakeningTarget(p23: userdata, p24: number) -- Line: 169
    -- upvalues: getCharacter (copy), ReplicatedStorage (copy), Players (copy), Teams (copy)
    local v25, v26 = getCharacter(p23);
    local Value = ReplicatedStorage.Football.Value;

    if not (v25 and (v26 and (Value and not Value.Anchored))) then
        return nil;
    end;

    local Char = Value:FindFirstChild("Char");
    local OnPlayer = Value:FindFirstChild("OnPlayer");

    if Char then
        Char = Char.Value;
    end;

    if not (Char and (Char ~= v25 and (Value.Parent == Char and (OnPlayer and OnPlayer.Value)))) then
        return nil;
    end;

    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local v27 = Char:FindFirstChildOfClass("Humanoid");
    local Values = Char:FindFirstChild("Values");
    local v28;

    if Values then
        v28 = Values:FindFirstChild("HasBall");
    else
        v28 = Values;
    end;

    if not (HumanoidRootPart and (v27 and (v27.Health > 0 and (v28 and v28.Value)))) then
        return nil;
    end;

    if p24 < (HumanoidRootPart.Position - v26.Position).Magnitude then
        return nil;
    end;

    local PlayerFromCharacter = Players:GetPlayerFromCharacter(Char);

    if PlayerFromCharacter then
        if not (PlayerFromCharacter.Team and (PlayerFromCharacter.Team ~= Teams.Visitor and PlayerFromCharacter.Team ~= p23.Team)) then
            return nil;
        end;
    elseif not Char:GetAttribute("IsTrainingDummy") then
        return nil;
    end;

    local Goalie = Values:FindFirstChild("Goalie");
    local IsInPenalty = Values:FindFirstChild("IsInPenalty");
    local Dribbling = Values:FindFirstChild("Dribbling");

    if Goalie and (Goalie.Value and (IsInPenalty and IsInPenalty.Value)) then
        return nil;
    end;

    if Dribbling and Dribbling.Value then
        return nil;
    end;

    return Char;
end;

function u6.rules.aikuAwakeningTarget(p29: userdata, p30: number, p31: boolean?) -- Line: 197
    -- upvalues: u6 (copy), Popup (copy)
    local v32 = u6.findAikuAwakeningTarget(p29, p30);

    if not v32 and p31 ~= false then
        Popup.Popup(p29, "Be close to an opponent with the ball!");
    end;

    return v32;
end;

function u6.rules.ballHolderInRange(p33: userdata?, p34: number?, p35: boolean?) -- Line: 203
    -- upvalues: getCharacter (copy), u6 (copy), ReplicatedStorage (copy), Popup (copy)
    local v36 = p34 or 80;
    local v37 = getCharacter(p33);

    if u6.findBallHolderInRange(v37, v36) then
        return true;
    end;

    if p35 ~= false then
        if ReplicatedStorage.Football.Value.Parent == workspace then
            Popup.Popup(p33, "Ball is loose!");
        else
            Popup.Popup(p33, "No ball holder within " .. v36 .. " studs!");
        end;
    end;

    return false;
end;

function u6.rules.looseBall(p38: userdata, p39: number?, p40: boolean?, p41: table?) -- Line: 222
    -- upvalues: getCharacter (copy), ReplicatedStorage (copy), Popup (copy)
    local v42 = p39 or 30;
    local v43, v44 = getCharacter(p38);
    local Value = ReplicatedStorage.Football.Value;

    if not (v43 and (v44 and (Value and (Value:IsA("BasePart") and Value.Parent == workspace)))) then
        if p40 ~= false then
            Popup.Popup(p38, "Ball must be loose and within range! (" .. v42 .. ")");
        end;

        return false;
    end;

    if p41 then
        local OnPlayer = Value:FindFirstChild("OnPlayer");

        if Value.Anchored or (not OnPlayer or OnPlayer.Value) then
            return false;
        end;

        local Attribute = Value:GetAttribute("GKThrowLockout");

        if p41.respectThrowLockout and (type(Attribute) == "number" and tick() < Attribute) then
            return false;
        end;
    end;

    local Char = Value:FindFirstChild("Char");

    if Char then
        Char = Char.Value;
    end;

    local v45;

    if Char then
        v45 = Char:FindFirstChild("Values");
    else
        v45 = Char;
    end;

    if v45 then
        v45 = v45:FindFirstChild("Goalie");
    end;

    if not (p41 and p41.allowGoalkeeperThrows) and (Char and (Char.Name == "GK" or v45 and v45.Value)) then
        if p40 ~= false then
            Popup.Popup(p38, "Ball was just thrown by the goal keeper");
        end;

        return false;
    end;

    if v42 >= (v44.Position - Value.Position).Magnitude then
        return true;
    end;

    if p40 ~= false then
        Popup.Popup(p38, "Ball must be loose and within range! (" .. v42 .. ")");
    end;

    return false;
end;

function u6.rules.canAct(p46: userdata?, p47: boolean?) -- Line: 256
    -- upvalues: getCharacter (copy), Players (copy), Popup (copy)
    local v48, v49, v50, v51;

    if p46 then
        v48, v49, v50, v51 = getCharacter(p46);
    else
        v48 = nil;
        v49 = nil;
        v50 = nil;
        v51 = nil;
    end;

    local v52;

    if p46 then
        v52 = p46:FindFirstChild("PlayerStats");
    else
        v52 = p46;
    end;

    if p46 then
        if p46.Parent == Players then
            local Team = p46.Team;

            if Team then
                if p46.Team.Name == "Visitor" then
                    v52 = false;
                else
                    local v53 = v48 and v48.Parent;

                    if v53 then
                        if v49 then
                            if v50 then
                                if v50.Health > 0 then
                                    local v54 = v51 and v51:FindFirstChild("HasBall") and (v51:FindFirstChild("InCutscene") and not v51.InCutscene.Value);

                                    if v54 then
                                        if v52 then
                                            v52 = v52:FindFirstChild("Style");
                                        end;
                                    else
                                        v52 = v54;
                                    end;
                                else
                                    v52 = false;
                                end;
                            else
                                v52 = v50;
                            end;
                        else
                            v52 = v49;
                        end;
                    else
                        v52 = v53;
                    end;
                end;
            else
                v52 = Team;
            end;
        else
            v52 = false;
        end;
    else
        v52 = p46;
    end;

    if v51 then
        v51 = v51:FindFirstChild("Db");
    end;

    if v52 and not (v51 and v51.Value) then
        return true;
    end;

    if p47 ~= false then
        Popup.Popup(p46, "Cannot use an ability right now!");
    end;

    return false;
end;

local function ownGoalkeeperBox(p55: userdata?) -- Line: 273
    if p55 then
        p55 = p55.Team;
    end;

    local AI = workspace:FindFirstChild("AI");

    if not (p55 and (p55.Name == "Home" or p55.Name == "Away") and AI) then
        return nil;
    end;

    local v56 = AI:FindFirstChild(p55.Name);

    if v56 then
        v56 = v56:FindFirstChild("PenaltyBox");
    end;

    if not (v56 and (v56:IsA("BasePart") and v56)) then
        v56 = nil;
    end;

    return v56;
end;

function u6.rules.ballInOwnGoalkeeperBox(p57: userdata?, p58: boolean?) -- Line: 283
    -- upvalues: ownGoalkeeperBox (copy), ReplicatedStorage (copy), Popup (copy)
    local v59 = ownGoalkeeperBox(p57);
    local Value = ReplicatedStorage.Football.Value;

    if v59 and (Value and Value:IsA("BasePart")) then
        local v60 = v59.CFrame:PointToObjectSpace(Value.Position);
        local v61 = v59.Size * 0.5;

        if math.abs(v60.X) <= v61.X and math.abs(v60.Z) <= v61.Z then
            return true;
        end;
    end;

    if p58 ~= false then
        Popup.Popup(p57, "Ball must be inside your goalkeeper box!");
    end;

    return false;
end;

function u6.rules.nearOwnGoalkeeperBox(p62: userdata?, p63: number, p64: boolean?) -- Line: 295
    -- upvalues: ownGoalkeeperBox (copy), getCharacter (copy), Popup (copy)
    local v65 = ownGoalkeeperBox(p62);
    local v66, v67 = getCharacter(p62);

    if v65 and (v66 and v67) then
        local v68 = v65.CFrame:PointToObjectSpace(v67.Position);
        local v69 = v65.Size * 0.5;
        local v70 = math.abs(v68.X) - v69.X;
        local math_max_ret = math.max(v70, 0);
        local v71 = math.abs(v68.Y) - v69.Y;
        local math_max_ret2 = math.max(v71, 0);
        local v72 = math.abs(v68.Z) - v69.Z;
        local math_max_ret3 = math.max(v72, 0);

        if Vector3.new(math_max_ret, math_max_ret2, math_max_ret3).Magnitude <= p63 then
            return true;
        end;
    end;

    if p64 ~= false then
        Popup.Popup(p62, "Be within " .. p63 .. " studs of your goalkeeper box!");
    end;

    return false;
end;

function u6.rules.isAwakened(p73: userdata?, p74: boolean?) -- Line: 312
    -- upvalues: Popup (copy)
    if p73.PlayerStats.InAwakening.Value ~= false then
        return true;
    end;

    if p74 ~= false then
        Popup.Popup(p73, "Must not have the ball!");
    end;

    return false;
end;

function u6.rules.grounded(p75: userdata?, p76: boolean?) -- Line: 322
    -- upvalues: getCharacter (copy), Popup (copy)
    local v77, _, v78, v79 = getCharacter(p75);

    if v79.Stunned.Value then
        if p76 ~= false then
            Popup.Popup(p75, "You are stunned!");
        end;

        return false;
    end;

    if v77.IsRagdoll.Value then
        if p76 ~= false then
            Popup.Popup(p75, "You are ragdolled!");
        end;

        return false;
    end;

    if v79.Sliding.Value then
        if p76 ~= false then
            Popup.Popup(p75, "You are sliding!");
        end;

        return false;
    end;

    if v77 and v78:GetState() == Enum.HumanoidStateType.Running then
        return true;
    end;

    if p76 ~= false then
        Popup.Popup(p75, "Must be on the ground!");
    end;

    return false;
end;

function u6.rules.ballTeammate(p80: userdata?, p81: number?, p82: boolean) -- Line: 351
    -- upvalues: getCharacter (copy), ReplicatedStorage (copy), Players (copy), Popup (copy)
    local _, v83, _, _ = getCharacter(p80);
    local Value = ReplicatedStorage.Football.Value;
    local OnPlayer = Value.OnPlayer;
    local Value2 = Value.Char.Value;
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(Value2);

    if not OnPlayer.Value or PlayerFromCharacter.Team ~= p80.Team then
        if p82 ~= false then
            Popup.Popup(p80, "Teammate must have ball!");
        end;

        return false;
    end;

    if not Value2:FindFirstChild("HumanoidRootPart") or p81 >= (Value2.HumanoidRootPart.Position - v83.Position).Magnitude then
        return Value2;
    end;

    if p82 ~= false then
        Popup.Popup(p80, "Teammate must be in range!");
    end;

    return false;
end;

if RunService:IsClient() then
    task.defer(function() -- Line: 375
        -- upvalues: ReplicatedStorage (copy), u6 (copy)
        local AbilityController = require(ReplicatedStorage.Controllers.AbilityController);
        local u84 = { "AbilityOne", "AbilityTwo", "AbilityThree" };

        function u6.rules.slotReady(p85: number) -- Line: 378
            -- upvalues: AbilityController (copy), u84 (copy)
            return AbilityController.legacy[u84[p85]] <= tick();
        end;
    end);
    local getPlayerTarget = require(ReplicatedStorage.Modules.getPlayerTarget);
    local u86 = nil;

    function u6.rules.enemyTarget(u87: number, u88: boolean?, p89: any) -- Line: 390
        -- upvalues: getCharacter (copy), LocalPlayer (copy), getPlayerTarget (copy), Players (copy), u86 (ref), Teams (copy), Popup (copy)
        local _, v90 = getCharacter(LocalPlayer);

        if not v90 then
            return false;
        end;

        local Position = v90.Position;
        local u91 = false;
        local v93 = getPlayerTarget(true, function(p92) -- Line: 398
            -- upvalues: Players (ref), u86 (ref), Position (copy), u87 (copy), u91 (ref), Teams (ref), LocalPlayer (ref), u88 (copy)
            local PlayerFromCharacter = Players:GetPlayerFromCharacter(p92);
            u86 = workspace:FindFirstChild("PassRig");

            if p92 == u86 then
                if u87 >= (p92.HumanoidRootPart.Position - Position).Magnitude then
                    return true;
                end;

                u91 = true;

                return false;
            end;

            if not (PlayerFromCharacter and (PlayerFromCharacter.Team ~= Teams.Visitor and PlayerFromCharacter.Team ~= LocalPlayer.Team)) then
                return false;
            end;

            if p92.Values.Goalie.Value and p92.Values.IsInPenalty.Value then
                return false;
            end;

            if u87 < (p92.HumanoidRootPart.Position - Position).Magnitude then
                return false;
            end;

            return (not u88 or p92.Values.HasBall.Value) and true or false;
        end);

        if v93 then
            return v93;
        end;

        if p89 == false then
            return false;
        end;

        local v94 = u91 and " (OUT OF RANGE)" or "";

        if u88 then
            Popup.Popup(LocalPlayer, (`Must be close and facing an enemy with the ball!{v94}`));
        else
            Popup.Popup(LocalPlayer, (`Must be close and facing an enemy!{v94}`));
        end;

        return false;
    end;

    function u6.rules.friendlyTarget(u95: number, u96: boolean, p97: boolean?) -- Line: 451
        -- upvalues: getCharacter (copy), LocalPlayer (copy), getPlayerTarget (copy), Players (copy), u86 (ref), Popup (copy)
        local _, v98 = getCharacter(LocalPlayer);

        if not v98 then
            return false;
        end;

        local Position = v98.Position;
        local u99 = false;
        local v101 = getPlayerTarget(true, function(p100) -- Line: 458
            -- upvalues: Players (ref), u86 (ref), Position (copy), u95 (copy), u99 (ref), LocalPlayer (ref), u96 (copy)
            local PlayerFromCharacter = Players:GetPlayerFromCharacter(p100);
            u86 = workspace:FindFirstChild("PassRig");

            if p100 == u86 then
                if u95 >= (p100.HumanoidRootPart.Position - Position).Magnitude then
                    return true;
                end;

                u99 = true;

                return false;
            end;

            if not PlayerFromCharacter or PlayerFromCharacter.Team ~= LocalPlayer.Team then
                return false;
            end;

            if u96 and (p100.Values.Goalie.Value and p100.Values.IsInPenalty.Value) then
                return false;
            end;

            if u95 >= (p100.HumanoidRootPart.Position - Position).Magnitude then
                return true;
            end;

            u99 = true;

            return false;
        end);

        if v101 then
            return v101;
        end;

        if p97 ~= false then
            Popup.Popup(LocalPlayer, (`Must be facing a teammate!{u99 and " (OUT OF RANGE)" or ""}`));
        end;

        return false;
    end;

    function u6.rules.anyTarget(u102: boolean, p103: boolean) -- Line: 502
        -- upvalues: getCharacter (copy), LocalPlayer (copy), getPlayerTarget (copy), Players (copy), u86 (ref), Popup (copy)
        local _, v104 = getCharacter(LocalPlayer);

        if not v104 then
            return false;
        end;

        local Position = v104.Position;
        local u105 = false;
        local v107 = getPlayerTarget(true, function(p106) -- Line: 509
            -- upvalues: Players (ref), u86 (ref), Position (copy), u102 (copy), u105 (ref)
            Players:GetPlayerFromCharacter(p106);
            u86 = workspace:FindFirstChild("PassRig");

            if p106 and p106 == u86 then
                if u102 >= (p106.HumanoidRootPart.Position - Position).Magnitude then
                    return true;
                end;

                u105 = true;

                return false;
            end;

            if u102 >= (p106.HumanoidRootPart.Position - Position).Magnitude then
                return true;
            end;

            u105 = true;

            return false;
        end);

        if v107 then
            return v107;
        end;

        if p103 ~= false then
            Popup.Popup(LocalPlayer, (`Must be facing a player!{u105 and " (OUT OF RANGE)" or ""}`));
        end;

        return false;
    end;

    local MouseCast = require(ReplicatedStorage.ClientModules.MouseCast);
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.CollisionGroup = "Ball";
    RaycastParams_new_ret.RespectCanCollide = true;
    RaycastParams_new_ret.FilterDescendantsInstances = { workspace.Debris };
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;

    function u6.clientAimTarget() -- Line: 546
        -- upvalues: MouseCast (copy), RaycastParams_new_ret (copy)
        local v108, v109 = MouseCast:WithParamsCenter(RaycastParams_new_ret);

        if v108 then
            return v108.Position;
        end;

        return v109;
    end;
end;

function u6.checks.onball(p110) -- Line: 558
    -- upvalues: u6 (copy)
    return u6.rules.onball(p110, false);
end;

function u6.checks.offball(p111) -- Line: 562
    -- upvalues: u6 (copy)
    return u6.rules.offball(p111, false);
end;

function u6.checks.grounded(p112) -- Line: 566
    -- upvalues: u6 (copy)
    return u6.rules.grounded(p112, false);
end;

if RunService:IsClient() then
    function u6.checks.friendlyTarget(p113, p114) -- Line: 571
        -- upvalues: u6 (copy)
        return u6.rules.friendlyTarget(p113, p114, false);
    end;

    function u6.checks.enemyTarget(p115, p116) -- Line: 576
        -- upvalues: u6 (copy)
        return u6.rules.enemyTarget(p115, p116, false);
    end;

    function u6.checks.anyTarget(p117) -- Line: 580
        -- upvalues: u6 (copy)
        return u6.rules.anyTarget(p117, false);
    end;
end;

local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
RaycastParams_new_ret.RespectCanCollide = true;
RaycastParams_new_ret.CollisionGroup = "Player";
RaycastParams_new_ret.FilterDescendantsInstances = { workspace.SmallSquare };

local function refreshFilter() -- Line: 592
    -- upvalues: RaycastParams_new_ret (copy), Players (copy)
    RaycastParams_new_ret.FilterDescendantsInstances = { workspace.SmallSquare };

    for _, v in Players:GetPlayers() do
        if v.Character then
            RaycastParams_new_ret:AddToFilter(v.Character);
        end;
    end;
end;

local function OnPlayerAdded(p118: userdata) -- Line: 601
    -- upvalues: refreshFilter (copy)
    p118.CharacterAdded:Connect(refreshFilter);
end;

for _, v in Players:GetPlayers() do
    task.spawn(OnPlayerAdded, v);
end;

Players.PlayerAdded:Connect(OnPlayerAdded);
refreshFilter();

function u6.wallCheck(p119, p120) -- Line: 611
    -- upvalues: RaycastParams_new_ret (copy)
    local v121 = workspace:Raycast(p119, p120, RaycastParams_new_ret);

    if not v121 then
        return false;
    end;

    print(v121.Instance);

    return true;
end;

function u6.clearMovers(p122) -- Line: 620
    for _, descendant in p122:GetDescendants() do
        if descendant:IsA("BodyMover") then
            descendant:Destroy();
        end;
    end;
end;

function u6.createAfterImage(p123, p124) -- Line: 628
    -- upvalues: TweenService (copy), Debris (copy)
    if not p123 then
        return;
    end;

    p123.Archivable = true;
    local v125 = p123:Clone();
    v125.Name = "AfterImage";

    if v125 then
        local v126 = p124 or {};
        local NotAnchored = v126.NotAnchored;
        local v127 = v126.Duration or 0.5;
        local v128 = v126.FillColor or Color3.new(1, 0.435294, 0.435294);
        local v129 = v126.OutlineColor or Color3.new(0.639216, 0.258824, 0.129412);
        local Children = v125:GetChildren();

        for _, v in pairs(Children) do
            if v:IsA("Accessory") and (v.Name == "Cape" or (v.Name == "Peppermint Cape" or v.Name == "Santa Hat")) then
                v:Destroy();
            elseif v:IsA("Script") or (v:IsA("LocalScript") or v:IsA("Folder")) then
                v:Destroy();
            elseif v:IsA("Highlight") then
                v.FillColor = v128;
                v.OutlineColor = v129;
                v.OutlineTransparency = 0;
                v.FillTransparency = 0;
                local v130 = TweenService:Create(v, TweenInfo.new(v127, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    FillTransparency = 1,
                    OutlineTransparency = 1
                });
                v130:Play();
                Debris:AddItem(v130, v127);
            elseif v:IsA("MeshPart") or v:IsA("BasePart") then
                v.CanCollide = false;
                v.Anchored = v.Name == "HumanoidRootPart" and true or not NotAnchored;

                if v:FindFirstChildOfClass("SurfaceGui") then
                    v:FindFirstChildOfClass("SurfaceGui"):Destroy();
                end;

                if v:FindFirstChildOfClass("Decal") then
                    v:FindFirstChildOfClass("Decal"):Destroy();
                end;

                if v.Name ~= "HumanoidRootPart" then
                    if string.find(v.Name, "Hitbox") or (v.Name == "Football" or (v.Name == "PlrFootball" or (v.Name == "Ring" or v.Name == "WindEffects"))) then
                        v:Destroy();
                    else
                        v.Transparency = 0;
                        local v131 = TweenService:Create(v, TweenInfo.new(v127, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                            Transparency = 1
                        });
                        v131:Play();
                        Debris:AddItem(v131, v127);
                    end;
                end;
            elseif v:IsA("Accessory") then
                v.Handle.CanCollide = false;
                v.Handle.Anchored = not NotAnchored;
                v.Handle.Transparency = 0;
                local v132 = TweenService:Create(v.Handle, TweenInfo.new(v127, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Transparency = 1
                });
                v132:Play();
                Debris:AddItem(v132, v127);
            end;
        end;

        Debris:AddItem(v125, v127);
        v125.Parent = workspace.Debris;

        return v125;
    end;
end;

function u6.FastDashTo(p133: string, p134: vector, p135: number, p136: number, p137: any) -- Line: 707
    -- upvalues: Players (copy), TweenService (copy)
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(p133);
    local RaycastParams_new_ret2 = RaycastParams.new();
    RaycastParams_new_ret2.FilterType = Enum.RaycastFilterType.Include;
    RaycastParams_new_ret2.FilterDescendantsInstances = {
        workspace.Field,
        workspace.Colliders,
        workspace.Goals,
        workspace.SmallSquare
    };
    local v138 = p137 or Enum.EasingStyle.Quad;
    local v139 = p135 or 2;
    local v140 = p136 or 0.2;
    local HumanoidRootPart = p133:FindFirstChild("HumanoidRootPart");

    if HumanoidRootPart then
        local Position = HumanoidRootPart.Position;
        local v141 = p134 - Position;
        local v142 = workspace:Raycast(Position, v141, RaycastParams_new_ret2);

        if v142 then
            print(v142.Instance.Name, PlayerFromCharacter.Team, v142.Instance.Parent.Name);

            if v142.Instance.Parent.Name ~= "SmallSquare" or PlayerFromCharacter and (v142.Instance.Parent.Name == "SmallSquare" and not string.find(v142.Instance.Name, PlayerFromCharacter.Team.Name)) then
                p134 = v142.Position - v141.Unit * v139;
            end;
        end;

        local AlignPosition = Instance.new("AlignPosition");
        AlignPosition.Mode = Enum.PositionAlignmentMode.OneAttachment;
        AlignPosition.Attachment0 = HumanoidRootPart:FindFirstChild("RootAttachment");
        AlignPosition.Responsiveness = 200;
        AlignPosition.MaxForce = 100000;
        AlignPosition.Position = Position;
        AlignPosition.Parent = HumanoidRootPart;
        local v143 = TweenService:Create(AlignPosition, TweenInfo.new(v140, v138, Enum.EasingDirection.Out), {
            Position = p134
        });
        v143:Play();
        v143.Completed:Connect(function() -- Line: 754
            -- upvalues: AlignPosition (copy)
            AlignPosition:Destroy();
        end);

        return AlignPosition, v143;
    end;
end;

function u6.findNearestPlayer(p144: table) -- Line: 762
    -- upvalues: LocalPlayer (copy), Teams (copy), Players (copy)
    assert(p144.distance, "need distance for findNearestPlayer");
    local Team = LocalPlayer.Team;
    local v145;

    if Team == Teams.Away then
        v145 = Teams.Home;
    else
        v145 = Teams.Away;
    end;

    local v146 = p144.team or "Enemy";
    local includeGK = p144.includeGK;
    local Character = LocalPlayer.Character;

    if not Character then
        return;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local CFrame2 = HumanoidRootPart.CFrame;
    local LookVector = CFrame2.LookVector;
    local v147 = nil;

    for _, v in Players:GetPlayers() do
        local Character2 = v.Character;

        if Character2 then
            local HumanoidRootPart2 = Character2:FindFirstChild("HumanoidRootPart");
            local Values = Character2:FindFirstChild("Values");

            if HumanoidRootPart2 and Values then
                local Team2 = v.Team;

                if Team2 ~= Teams.Visitor then
                    if v146 ~= "Ally" or Team2 == Team then
                        if (v146 ~= "Enemy" or Team2 == v145) and (includeGK or not (Values.Goalie.Value and Values.IsInPenalty.Value)) then
                            local v148 = LookVector:Dot((HumanoidRootPart2.Position - CFrame2.Position).Unit);

                            if math.acos(v148) < 1.5707963267948966 and (p144.onBall and Values.HasBall.Value or not p144.onBall and Values.HasBall.Value == false) and (CFrame2.Position - HumanoidRootPart2.Position).Magnitude <= p144.distance then
                                v147 = Character2;
                                break;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;

    if v147 then
        return v147;
    end;

    local PassRig = workspace:FindFirstChild("PassRig");

    if PassRig then
        local Position = PassRig.HumanoidRootPart.CFrame.Position;

        if (CFrame2.Position - Position).Magnitude <= p144.distance then
            local v149 = LookVector:Dot((Position - CFrame2.Position).Unit);

            if math.acos(v149) < 1.5707963267948966 then
                return PassRig;
            end;
        end;
    end;
end;

function u6.findNearestEnemy(p150: userdata) -- Line: 844
    -- upvalues: getCharacter (copy), Players (copy)
    local v151, v152 = getCharacter(p150);

    if not (v151 and v152) then
        return nil;
    end;

    local v153 = (1 / 0);
    local v154 = nil;

    for _, v in Players:GetPlayers() do
        if v ~= p150 and (v.Team and (v.Team ~= p150.Team and v.Team.Name ~= "Visitor")) then
            local Character = v.Character;
            local v155;

            if Character then
                v155 = Character:FindFirstChild("HumanoidRootPart");
            else
                v155 = Character;
            end;

            local v156;

            if Character then
                v156 = Character:FindFirstChildOfClass("Humanoid");
            else
                v156 = Character;
            end;

            if Character and (Character.Parent and (v155 and (v156 and v156.Health > 0))) then
                local Magnitude = (v155.Position - v152.Position).Magnitude;

                if Magnitude < v153 then
                    v154 = Character;
                    v153 = Magnitude;
                end;
            end;
        end;
    end;

    return v154;
end;

function u6.invis(p157, p158) -- Line: 862
    for _, descendant in p157:GetDescendants() do
        if descendant.Name ~= "HumanoidRootPart" then
            if descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")) then
                if descendant.Transparency ~= 1 or descendant:GetAttribute("OriginalTransparency") then
                    if descendant:FindFirstChild("OrgTrans") then
                        descendant.Transparency = descendant.OrgTrans.Value;
                        descendant.OrgTrans:Destroy();
                    elseif p158 == 1 then
                        descendant:SetAttribute("OriginalTransparency", (tonumber(descendant.Transparency)));
                        descendant.Transparency = p158;
                    else
                        descendant.Transparency = p158;
                    end;
                end;
            elseif descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                if descendant:GetAttribute("OriginalTransparency") then
                    descendant.Enabled = true;
                    descendant:SetAttribute("OriginalTransparency", nil);
                elseif descendant.Enabled and (descendant.Parent.Name ~= "HumanoidRootPart" and descendant.Parent.Parent.Name ~= "HumanoidRootPart") then
                    descendant:SetAttribute("OriginalTransparency", true);
                    descendant.Enabled = false;

                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = not descendant.Enabled;
                    end;
                end;
            end;
        end;
    end;
end;

function u6.destroyDebrisInstances(p159: table) -- Line: 903
    for _, v in p159 do
        local v160 = workspace.Debris:FindFirstChild(v);

        if v160 then
            v160:Destroy();
        end;
    end;
end;

function u6.playAnims(p161: table, p162: any) -- Line: 913
    for _, v in p161 do
        v.Priority = Enum.AnimationPriority.Action4;
        v.Looped = false;
        v:Play(0, 1, p162 or 1);
    end;

    return p161;
end;

function u6.incrementRageBars() -- Line: 922
    -- upvalues: ReplicatedStorage (copy), Players (copy)
    while task.wait(1) do
        if ReplicatedStorage.GameValues.State.Value == "Playing" then
            for _, v in Players:GetPlayers() do
                local Character = v.Character;

                if Character and not (Character:GetAttribute("Omnivision") or (Character:GetAttribute("DestroyerMode") or (v.Team == game:GetService("Teams").Visitor or v.PlayerStats.Style.Value ~= "NEL Isagi" and v.PlayerStats.Style.Value ~= "NEL Rin"))) and (v.PlayerStats.InAwakening.Value == false and (Character and not Character.Values.HasBall.Value)) then
                    local v163 = (Character:GetAttribute("RageBar") or 0) + 0.0325;
                    Character:SetAttribute("RageBar", (math.min(v163, 1)));
                end;
            end;
        end;
    end;
end;

function u6.firstPlayerNearBall(p164: table) -- Line: 936
    -- upvalues: ReplicatedStorage (copy), RunService (copy), Players (copy), Teams (copy)
    local Value = ReplicatedStorage.Football.Value;

    if not Value then
        return;
    end;

    local Position = Value.Position;
    local v165 = {};

    if RunService:IsStudio() then
        local PassRig = workspace:FindFirstChild("PassRig");
        table.insert(v165, PassRig);
    end;

    for _, v in Players:GetPlayers() do
        if v ~= Players.LocalPlayer and v.Team ~= Teams:FindFirstChild("Visitor") then
            if p164.team == "Same" then
                if v.Team == Players.LocalPlayer.Team then
                    if v.Character and (v.Character:FindFirstChild("HumanoidRootPart") and (v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0)) then
                        table.insert(v165, v.Character);
                    end;
                end;
            elseif p164.team ~= "Enemy" or v.Team ~= Players.LocalPlayer.Team then
                if v.Character and (v.Character:FindFirstChild("HumanoidRootPart") and (v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0)) then
                    table.insert(v165, v.Character);
                end;
            end;
        end;
    end;

    local v166 = p164.rangeMin or 0;
    local range = p164.range;
    local v167 = nil;

    for _, v in v165 do
        local Magnitude = (Position - v.HumanoidRootPart.Position).Magnitude;

        if Magnitude < range and v166 < Magnitude then
            v167 = v;
            range = Magnitude;
        end;
    end;

    return v167, range;
end;

function u6.findPlayersNearBall(p168: table) -- Line: 977
    -- upvalues: ReplicatedStorage (copy), RunService (copy), Players (copy), Teams (copy)
    local Value = ReplicatedStorage.Football.Value;

    if not Value then
        return;
    end;

    local Position = Value.Position;
    local v169 = {};

    if RunService:IsStudio() then
        local PassRig = workspace:FindFirstChild("PassRig");
        table.insert(v169, PassRig);
    end;

    for _, v in Players:GetPlayers() do
        if v ~= Players.LocalPlayer and v.Team ~= Teams:FindFirstChild("Visitor") then
            if p168.team == "Same" then
                if v.Team == Players.LocalPlayer.Team then
                    if v.Character and (v.Character:FindFirstChild("HumanoidRootPart") and (v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0)) then
                        table.insert(v169, v.Character);
                    end;
                end;
            elseif p168.team ~= "Enemy" or v.Team ~= Players.LocalPlayer.Team then
                if v.Character and (v.Character:FindFirstChild("HumanoidRootPart") and (v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0)) then
                    table.insert(v169, v.Character);
                end;
            end;
        end;
    end;

    local v170 = p168.rangeMin or 0;
    local v171 = p168.range or 500;
    local v172 = {};

    for _, v in v169 do
        local Magnitude = (Position - v.HumanoidRootPart.Position).Magnitude;

        if Magnitude < v171 and v170 < Magnitude then
            table.insert(v172, {
                character = v,
                distance = Magnitude
            });
        end;
    end;

    table.sort(v172, function(p173, p174) -- Line: 1017
        return p173.distance < p174.distance;
    end);
    local v175 = {};

    for i = 1, math.min(p168.amount or 1, #v172) do
        table.insert(v175, v172[i]);
        local _ = i;
    end;

    return v175;
end;

if RunService:IsClient() then
    local StatesController = require(ReplicatedStorage.Controllers.StatesController);
    local CameraController = require(ReplicatedStorage.Controllers.CameraController);
    local KnitClient = require(ReplicatedStorage.Packages.Knit.KnitClient);
    local u176 = nil;
    KnitClient.OnStart():andThen(function() -- Line: 1036
        -- upvalues: u176 (ref), KnitClient (copy)
        u176 = KnitClient.GetService("AbilityService");
    end);

    function u6.clientCutsceneSkill(u177: any, u178: any, p179: number, u180: number, u181: boolean?, p182: vector?, p183: boolean?) -- Line: 1040
        -- upvalues: Players (copy), Teams (copy), u6 (copy), CameraController (copy), StatesController (copy), LocalPlayer (copy), u176 (ref)
        local ABC = u177.ABC;

        if ABC then
            ABC:Clean();
        end;

        for _, v in Players:GetPlayers() do
            if v.Team ~= Teams.Visitor then
                local Character = u6.getCharacter(v);

                if Character.Parent then
                    u6.invis(Character, 0);
                end;
            end;
        end;

        CameraController.Cutscene = true;
        StatesController.States.Ability = true;
        local u184 = LocalPlayer.PlayerStats.Style.Value == "Reo";
        ABC:Add(function() -- Line: 1057
            -- upvalues: CameraController (ref), StatesController (ref), u180 (copy), u184 (copy), u177 (copy), u178 (copy)
            CameraController.Cutscene = false;
            StatesController.States.Ability = false;

            if u180 and not u184 then
                u177:AbilityCooldown(tostring(u180), u178.Cooldown);
            end;
        end);

        if u180 and u184 then
            u177:AbilityCooldown(tostring(u180), u178.Cooldown);
        end;

        ABC:Add(task.delay(p179, function() -- Line: 1071
            -- upvalues: ABC (copy)
            ABC:Clean();
        end));

        if u181 and not p183 then
            ABC:Add(u6.execute.shot(u178, p182 or workspace.CurrentCamera.CFrame.LookVector, ABC));
        end;

        if not p183 then
            print("client ability connection");
            ABC:Connect(u176.Ability, function(p185, p186) -- Line: 1088
                -- upvalues: u181 (copy), ABC (copy)
                print(p185, p186);

                if u181 then
                    task.wait(0.2);
                end;

                ABC:Clean();
            end);
        end;
    end;
end;

function u6.serverCutsceneSkill(u187: userdata, u188: userdata, u189: userdata, p190: number, p191: any, u192: any) -- Line: 1099
    -- upvalues: RunService (copy), ReplicatedStorage (copy), ServerScriptService (copy), Players (copy), FindCurveDirection (copy)
    if RunService:IsClient() then
        return false;
    end;

    if typeof(u187) ~= "Instance" or not (u187:IsA("Player") and (typeof(u188) == "Instance" and (u188:IsA("ModuleScript") and (typeof(p190) == "number" and p190 >= 0)))) then
        return false;
    end;

    local Character = u187.Character;

    if Character then
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local u193 = Character:FindFirstChildOfClass("Humanoid");
        local Values = Character:FindFirstChild("Values");

        if Values then
            Values = Values:FindFirstChild("InCutscene");
        end;

        local AwakeningCutscene = ReplicatedStorage.GameValues:FindFirstChild("AwakeningCutscene");

        if not (HumanoidRootPart and (u193 and (u193.Health > 0 and (Values and not (Values.Value or (not AwakeningCutscene or AwakeningCutscene.Value)))))) then
            return false;
        end;

        local AbilityService = require(ServerScriptService.KnitServer.Services.AbilityService);
        local BallService = require(ServerScriptService.KnitServer.Services.BallService);
        local NewBall = BallService.NewBall;

        if NewBall then
            NewBall = NewBall.Ball;
        end;

        local PlrFootball = Character:FindFirstChild("PlrFootball");

        if PlrFootball then
            PlrFootball = PlrFootball:FindFirstChild("BallAnims");
        end;

        if PlrFootball then
            PlrFootball = PlrFootball:FindFirstChild("AnimationController");
        end;

        local u194 = ReplicatedStorage.Assets and ReplicatedStorage.Assets:FindFirstChild("ReplicatedAnims") and ReplicatedStorage.Assets.ReplicatedAnims:FindFirstChild("BallHidden");

        if not (NewBall and (NewBall:IsA("BasePart") and (PlrFootball and u194))) then
            return false;
        end;

        local success, result = pcall(function() -- Line: 1152
            -- upvalues: PlrFootball (copy), u194 (copy)
            return PlrFootball:LoadAnimation(u194);
        end);

        if not (success and result) then
            warn("[serverCutsceneSkill] could not load hidden-ball animation:", result);

            return false;
        end;

        local u195 = false;

        local function clearCutsceneState() -- Line: 1161
            -- upvalues: u195 (ref), AwakeningCutscene (copy), Values (copy), result (copy)
            if u195 then
                return;
            end;

            u195 = true;

            if AwakeningCutscene.Parent then
                AwakeningCutscene.Value = false;
            end;

            if Values.Parent then
                Values.Value = false;
            end;

            pcall(function() -- Line: 1172
                -- upvalues: result (ref)
                result:Stop();
            end);
        end;

        local u196 = p191 == true and true or p191 == "shot";
        local u197 = p191 == "pass";
        local u198;

        if u197 and u189 then
            u198 = u189.Target or nil;
        else
            u198 = nil;
        end;

        local u199;

        if u198 then
            u199 = Players:GetPlayerFromCharacter(u198) or nil;
        else
            u199 = nil;
        end;

        local Team = u187.Team;
        local CFrame2 = HumanoidRootPart.CFrame;
        local Parent = NewBall.Parent;
        local CFrame3 = NewBall.CFrame;
        local AssemblyLinearVelocity = NewBall.AssemblyLinearVelocity;
        local AssemblyAngularVelocity = NewBall.AssemblyAngularVelocity;
        local Char = NewBall:FindFirstChild("Char");
        local OnPlayer = NewBall:FindFirstChild("OnPlayer");
        local v200;

        if Char then
            v200 = Char.Value or nil;
        else
            v200 = nil;
        end;

        local v201;

        if OnPlayer then
            v201 = OnPlayer.Value or false;
        else
            v201 = false;
        end;

        local u202;

        if typeof(v200) == "Instance" and (v200:IsA("Model") and v200) then
            u202 = v200;
        else
            u202 = nil;
        end;

        local v203;

        if u202 then
            v203 = Players:GetPlayerFromCharacter(u202) or nil;
        else
            v203 = nil;
        end;

        local v204;

        if v203 then
            v204 = v203.Team or nil;
        else
            v204 = nil;
        end;

        local u205;

        if u202 then
            u205 = u202:FindFirstChildOfClass("Humanoid") or nil;
        else
            u205 = nil;
        end;

        local u206;

        if u202 then
            u206 = u202:FindFirstChild("HumanoidRootPart") or nil;
        else
            u206 = nil;
        end;

        local v207;

        if u202 then
            v207 = u202:FindFirstChild("Values") or nil;
        else
            v207 = nil;
        end;

        local v208 = v207 and v207:FindFirstChild("HasBall") or nil;

        if u202 then
            if Parent == u202 then
                if v201 then
                    if v208 then
                        v208 = v208.Value;
                    end;
                else
                    v208 = v201;
                end;
            else
                v208 = false;
            end;
        else
            v208 = u202;
        end;

        local u209;

        if u192 then
            u209 = u192.onPassPickup;
        else
            u209 = u192;
        end;

        local u210;

        if u192 then
            u210 = u192.onComplete;
        else
            u210 = u192;
        end;

        if u192 then
            u192 = u192.onAbort;
        end;

        local success2, result2 = pcall(function() -- Line: 1210
            -- upvalues: HumanoidRootPart (copy), BallService (copy), NewBall (copy), ReplicatedStorage (ref), Values (copy), u188 (copy), u189 (copy), result (copy)
            local v211 = HumanoidRootPart;
            v211.CFrame = v211.CFrame * CFrame.new(0, 11.166 - HumanoidRootPart.Position.Y, 0);
            BallService.NewBall:Remove();

            if BallService.NewBall.Ball ~= NewBall then
                error("ball changed during cutscene setup");
            end;

            NewBall.Parent = ReplicatedStorage;
            ReplicatedStorage.GameValues.AwakeningCutscene.Value = true;
            Values.Value = true;
            HumanoidRootPart.CFrame = CFrame.lookAlong(HumanoidRootPart.Position, (HumanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit);
            ReplicatedStorage.VfxSpawn:FireAllClients(u188, u189);
            result.Priority = Enum.AnimationPriority.Action4;
            result:Play();
        end);

        if success2 then
            task.delay(p190, function() -- Line: 1291
                -- upvalues: u195 (ref), AwakeningCutscene (copy), Values (copy), result (copy), u187 (copy), Players (ref), Character (copy), HumanoidRootPart (copy), u193 (copy), Team (copy), BallService (copy), NewBall (copy), ReplicatedStorage (ref), u197 (copy), u198 (copy), u199 (copy), u196 (copy), u209 (copy), FindCurveDirection (ref), u210 (copy), AbilityService (copy), u192 (copy)
                if not u195 then
                    u195 = true;

                    if AwakeningCutscene.Parent then
                        AwakeningCutscene.Value = false;
                    end;

                    if Values.Parent then
                        Values.Value = false;
                    end;

                    pcall(function() -- Line: 1172
                        -- upvalues: result (ref)
                        result:Stop();
                    end);
                end;

                local u212 = false;
                local success3, result3 = pcall(function() -- Line: 1295
                    -- upvalues: u187 (ref), Players (ref), Character (ref), HumanoidRootPart (ref), u193 (ref), Team (ref), BallService (ref), NewBall (ref), ReplicatedStorage (ref), u197 (ref), u198 (ref), u199 (ref), u196 (ref), u209 (ref), FindCurveDirection (ref), u210 (ref), u212 (ref), AbilityService (ref)
                    print("cutscene ended ----------");

                    if u187.Parent ~= Players or (u187.Character ~= Character or not (Character.Parent and (HumanoidRootPart.Parent == Character and (u193.Parent == Character and (u193.Health > 0 and u187.Team == Team))))) then
                        if BallService.NewBall.Ball == NewBall and NewBall.Parent == ReplicatedStorage then
                            NewBall.Parent = workspace;
                            local success3, result3 = pcall(function() -- Line: 1309
                                -- upvalues: BallService (ref)
                                BallService:RefreshBallInstance();
                            end);

                            if not success3 then
                                warn("[serverCutsceneSkill] abort ball refresh failed:", result3);
                            end;
                        end;

                        return;
                    end;

                    if BallService.NewBall.Ball ~= NewBall or NewBall.Parent ~= ReplicatedStorage then
                        return;
                    end;

                    NewBall.Parent = workspace;
                    local success3, result3 = pcall(function() -- Line: 1325
                        -- upvalues: BallService (ref)
                        BallService:RefreshBallInstance();
                    end);

                    if not success3 then
                        error(result3);
                    end;

                    if not (BallService.NewBall.Ball and BallService.NewBall.Ball:IsA("BasePart")) then
                        error("ball refresh did not produce a live BasePart");
                    end;

                    if u197 then
                        local v213 = u198 and u198:FindFirstChild("HumanoidRootPart");
                        local v214 = u198 and u198:FindFirstChildOfClass("Humanoid");

                        if not (u198 and (u198.Parent and (v213 and (v214 and (v214.Health > 0 and not (u199 and (u199.Parent ~= Players or (u199.Character ~= u198 or u199.Team ~= Team)))))))) then
                            if BallService.NewBall.Ball == NewBall and NewBall.Parent == ReplicatedStorage then
                                NewBall.Parent = workspace;
                                local success4, result4 = pcall(function() -- Line: 1351
                                    -- upvalues: BallService (ref)
                                    BallService:RefreshBallInstance();
                                end);

                                if not success4 then
                                    warn("[serverCutsceneSkill] invalid pass-target refresh failed:", result4);
                                end;
                            end;

                            return;
                        end;
                    end;

                    if u196 then
                        local v215 = HumanoidRootPart.CFrame * CFrame.new(0, 0, -3);
                        u187.PlayerStats.HasShot.Value = true;
                        task.delay(0.6, function() -- Line: 1366
                            -- upvalues: u187 (ref)
                            u187.PlayerStats.HasShot.Value = false;
                        end);
                        game.ReplicatedStorage.GameValues.CutsceneShot.Value = true;
                        task.delay(1, function() -- Line: 1371
                            game.ReplicatedStorage.GameValues.CutsceneShot.Value = false;
                        end);
                        BallService.NewBall.Ball.Char.Value = Character;
                        BallService.NewBall:Remove(nil, "Shot");
                        BallService.NewBall.Ball.IFrame.Value = tick() + 1;
                        BallService.NewBall.Ball.CFrame = v215;
                        BallService.NewBall.Ball:SetNetworkOwner(u187);
                    elseif u197 then
                        local v216 = HumanoidRootPart.CFrame * CFrame.new(0, 0, -3);
                        u187.PlayerStats.HasShot.Value = true;
                        task.delay(0.6, function() -- Line: 1384
                            -- upvalues: u187 (ref)
                            u187.PlayerStats.HasShot.Value = false;
                        end);
                        local Ball = BallService.NewBall.Ball;
                        Ball.Char.Value = Character;
                        BallService.NewBall:Remove(nil, "Pass");
                        Ball.IFrame.Value = tick() + 2;
                        Ball.CFrame = v216;
                        Ball:SetNetworkOwner(u187);
                        task.spawn(function() -- Line: 1395
                            -- upvalues: u198 (ref), u199 (ref), Players (ref), Team (ref), BallService (ref), Ball (copy), u209 (ref), Character (ref)
                            local v217 = u198 and u198:FindFirstChild("HumanoidRootPart");
                            local v218 = u198 and u198:FindFirstChildOfClass("Humanoid");

                            if not (v217 and (v218 and not (u199 and (u199.Parent ~= Players or (u199.Character ~= u198 or u199.Team ~= Team))))) then
                                return;
                            end;

                            local function confirmExactPickup() -- Line: 1409
                                -- upvalues: u198 (ref), u199 (ref), Players (ref), Team (ref), BallService (ref), Ball (ref), u209 (ref)
                                local Values2 = u198:FindFirstChild("Values");

                                if Values2 then
                                    Values2 = Values2:FindFirstChild("HasBall");
                                end;

                                local v219 = not u199;

                                if not v219 then
                                    if u199.Parent == Players and u199.Character == u198 then
                                        v219 = u199.Team == Team;
                                    else
                                        v219 = false;
                                    end;
                                end;

                                if v219 then
                                    if BallService.NewBall.Ball == Ball and (Ball.Parent == u198 and Ball.Char.Value == u198) then
                                        if Values2 then
                                            Values2 = Values2.Value;
                                        end;
                                    else
                                        Values2 = false;
                                    end;
                                else
                                    Values2 = v219;
                                end;

                                if Values2 and u209 then
                                    local success4, result4 = pcall(u209, u198, Ball);

                                    if not success4 then
                                        warn("[serverCutsceneSkill] onPassPickup callback failed:", result4);
                                    end;
                                end;

                                return Values2;
                            end;

                            local v220 = tick() + 4;

                            while tick() <= v220 do
                                if BallService.NewBall.Ball ~= Ball then
                                    return;
                                end;

                                if Ball.Parent ~= workspace or Ball.OnPlayer.Value then
                                    confirmExactPickup();

                                    return;
                                end;

                                if Ball.Char.Value ~= Character or (v217.Parent ~= u198 or (v218.Parent ~= u198 or (v218.Health <= 0 or u199 and (u199.Parent ~= Players or (u199.Character ~= u198 or u199.Team ~= Team))))) then
                                    return;
                                end;

                                if (Ball.Position - v217.Position).Magnitude < 15 then
                                    Ball.IFrame.Value = tick() + 10;
                                    BallService.NewBall:Pickup(u198, v218, v217, true);
                                    confirmExactPickup();

                                    return;
                                end;

                                task.wait();
                            end;
                        end);
                    else
                        BallService.NewBall:Pickup(Character, u193, HumanoidRootPart);
                    end;

                    local v221 = FindCurveDirection(u187);
                    local v222 = nil;
                    local v223;

                    if u196 then
                        v223 = { BallService.NewBall.Ball, v221 };
                    else
                        v223 = u197 and { BallService.NewBall.Ball, u198 } or v222;
                    end;

                    if u210 then
                        local v224;

                        if v223 then
                            v224 = v223[1];
                        else
                            v224 = v223;
                        end;

                        if v223 then
                            v223 = v223[2];
                        end;

                        local success4, result4 = pcall(u210, v224, v223);
                        u212 = success4;

                        if not success4 then
                            warn("[serverCutsceneSkill] onComplete callback failed:", result4);
                        end;
                    else
                        local v225;

                        if v223 then
                            v225 = v223[1];
                        else
                            v225 = v223;
                        end;

                        if v223 then
                            v223 = v223[2];
                        end;

                        AbilityService.Client.Ability:Fire(u187, v225, v223);
                        u212 = true;
                    end;
                end);

                if not success3 then
                    warn("[serverCutsceneSkill] release failed:", result3);
                end;

                if not u212 and u192 then
                    local success4, result4 = pcall(u192);

                    if not success4 then
                        warn("[serverCutsceneSkill] onAbort callback failed:", result4);
                    end;
                end;
            end);

            return true;
        end;

        if not u195 then
            u195 = true;

            if AwakeningCutscene.Parent then
                AwakeningCutscene.Value = false;
            end;

            if Values.Parent then
                Values.Value = false;
            end;

            pcall(function() -- Line: 1172
                -- upvalues: result (copy)
                result:Stop();
            end);
        end;

        if HumanoidRootPart.Parent == Character then
            HumanoidRootPart.CFrame = CFrame2;
        end;

        if BallService.NewBall.Ball == NewBall and NewBall.Parent then
            if NewBall.Parent == ReplicatedStorage then
                NewBall.Parent = workspace;
            end;

            local v226 = v208 and u202.Parent;

            if v226 then
                if u205 then
                    if u205.Parent == u202 and u205.Health > 0 then
                        if u206 then
                            if u206.Parent == u202 then
                                v226 = not v203;

                                if not v226 then
                                    if v203.Parent == Players and v203.Character == u202 then
                                        v226 = v203.Team == v204;
                                    else
                                        v226 = false;
                                    end;
                                end;
                            else
                                v226 = false;
                            end;
                        else
                            v226 = u206;
                        end;
                    else
                        v226 = false;
                    end;
                else
                    v226 = u205;
                end;
            end;

            local v227;

            if v226 then
                local v228;
                v227, v228 = pcall(function() -- Line: 1254
                    -- upvalues: BallService (copy), u202 (copy), u205 (copy), u206 (copy)
                    BallService.NewBall:Pickup(u202, u205, u206);
                end);

                if v227 then
                    if BallService.NewBall.Ball == NewBall and (NewBall.Parent == u202 and (Char.Parent == NewBall and (Char.Value == u202 and OnPlayer.Parent == NewBall))) then
                        v227 = OnPlayer.Value;
                    else
                        v227 = false;
                    end;
                end;

                if not v227 then
                    warn("[serverCutsceneSkill] possession rollback failed:", v228);
                end;
            else
                v227 = false;
            end;

            if not v227 then
                pcall(function() -- Line: 1269
                    -- upvalues: BallService (copy)
                    BallService.NewBall:Remove();
                end);
                NewBall.Parent = workspace;
                NewBall.CFrame = CFrame3;
                NewBall.AssemblyLinearVelocity = AssemblyLinearVelocity;
                NewBall.AssemblyAngularVelocity = AssemblyAngularVelocity;

                if Char and Char.Parent == NewBall then
                    Char.Value = v200;
                end;

                if OnPlayer and OnPlayer.Parent == NewBall then
                    OnPlayer.Value = false;
                end;
            end;
        end;

        warn("[serverCutsceneSkill] setup failed:", result2);

        return false;
    end;

    warn("no character found for player: " .. u187.Name, "Cutscene: " .. u188.Name);
end;

function u6.Lerp(p229, p230, p231) -- Line: 1502
    return p229 + (p230 - p229) * p231;
end;

function u6.QuadBezier(p232, p233, p234, p235) -- Line: 1506
    -- upvalues: u6 (copy)
    local v236 = u6.Lerp(p232, p233, p235);
    local v237 = u6.Lerp(p233, p234, p235);

    return u6.Lerp(v236, v237, p235);
end;

function u6.countTeammates(p238: userdata) -- Line: 1517
    -- upvalues: Players (copy), Teams (copy)
    local Team = p238.Team;

    if not Team then
        return 0;
    end;

    local v239 = 0;

    for _, v in Players:GetPlayers() do
        if v ~= p238 and (v.Team == Team and v.Team ~= Teams:FindFirstChild("Visitor")) then
            local Character = v.Character;

            if Character and Character:FindFirstChild("HumanoidRootPart") then
                v239 = v239 + 1;
            end;
        end;
    end;

    return v239;
end;

function u6.findTopTeammates(p240: userdata, p241: number) -- Line: 1540
    -- upvalues: Players (copy), Teams (copy)
    local Character = p240.Character;

    if not (Character and Character:FindFirstChild("HumanoidRootPart")) then
        return {};
    end;

    local Team = p240.Team;
    local v242 = nil;
    local Goals = workspace:FindFirstChild("Goals");

    if Goals then
        if Team then
            Goals = Goals:FindFirstChild(Team.Name);
        else
            Goals = Team;
        end;
    end;

    if Goals then
        v242 = Goals.Position;
    end;

    local v243 = {};

    for _, v in Players:GetPlayers() do
        if v ~= p240 and (v.Team == Team and v.Team ~= Teams:FindFirstChild("Visitor")) then
            local Character2 = v.Character;
            local v244;

            if Character2 then
                v244 = Character2:FindFirstChild("HumanoidRootPart");
            else
                v244 = Character2;
            end;

            if v244 then
                local Values = Character2:FindFirstChild("Values");

                if not (Values and (Values:FindFirstChild("InCutscene") and Values.InCutscene.Value)) then
                    local v245 = v:FindFirstChild("GameStats") and v.GameStats:FindFirstChild("Goals");
                    table.insert(v243, {
                        char = Character2,
                        goals = v245 and v245.Value or 0,
                        dist = v242 and ((v244.Position - v242).Magnitude or (1 / 0)) or (1 / 0)
                    });
                end;
            end;
        end;
    end;

    local PassRig = workspace:FindFirstChild("PassRig");

    if PassRig and (PassRig:GetAttribute("IsTrainingDummy") and PassRig:FindFirstChild("HumanoidRootPart")) then
        table.insert(v243, {
            goals = 0,
            char = PassRig,
            dist = v242 and ((PassRig.HumanoidRootPart.Position - v242).Magnitude or (1 / 0)) or (1 / 0)
        });
    end;

    table.sort(v243, function(p246, p247) -- Line: 1577
        if p246.goals == p247.goals then
            return p246.dist < p247.dist;
        end;

        return p246.goals > p247.goals;
    end);
    local v248 = {};

    for i = 1, math.min(p241, #v243) do
        table.insert(v248, v243[i].char);
        local _ = i;
    end;

    return v248;
end;

local function grantPassShot(u249: string, u250: string, u251: userdata?, u252: userdata?, p253: userdata?, p254: number?) -- Line: 1593
    -- upvalues: RunService (copy), ReplicatedStorage (copy), Players (copy), HttpService (copy)
    local function dbg(...) -- Line: 1594
        -- upvalues: RunService (ref), u250 (copy)
        if RunService:IsStudio() then
            print("[" .. u250 .. "][grant]", ...);
        end;
    end;

    if not u252 then
        if u251 then
            u252 = u251.Character;
        else
            u252 = u251;
        end;
    end;

    local v255 = p253 or ReplicatedStorage.Football.Value;
    local u256;

    if u252 then
        u256 = u252:FindFirstChild("Values");
    else
        u256 = u252;
    end;

    if u256 then
        u256 = u256:FindFirstChild("HasBall");
    end;

    dbg("called; recipient =", u251 and (u251.Name or "nil") or "nil");

    if not (u251 and (u251.Parent == Players and (u251.Character == u252 and (v255 and (ReplicatedStorage.Football.Value == v255 and (v255.Parent == u252 and (v255:FindFirstChild("Char") and (v255.Char.Value == u252 and (u256 and u256.Value))))))))) then
        dbg("exact received possession no longer valid — no grant");

        return;
    end;

    local math_max_ret = math.max(0.1, p254 or 5);
    local u257 = HttpService:GenerateGUID(false);
    u251:SetAttribute(u249 .. "Token", u257);
    u251:SetAttribute(u249 .. "Until", workspace:GetServerTimeNow() + math_max_ret);
    u251:SetAttribute(u249, true);
    dbg(u249 .. " SET on", u251.Name);
    local u258 = false;
    local u259 = {};
    local u260 = nil;

    local function cleanup() -- Line: 1631
        -- upvalues: u258 (ref), u260 (ref), u259 (copy), u251 (copy), u249 (copy), u257 (copy), dbg (copy)
        if u258 then
            return;
        end;

        u258 = true;

        if u260 and coroutine.running() ~= u260 then
            pcall(task.cancel, u260);
        end;

        for _, v in u259 do
            v:Disconnect();
        end;

        if u251:GetAttribute(u249 .. "Token") == u257 then
            u251:SetAttribute(u249, nil);
            u251:SetAttribute(u249 .. "Token", nil);
            u251:SetAttribute(u249 .. "Until", nil);
        end;

        dbg(u249 .. " cleanup on", u251.Name);
    end;

    u260 = task.delay(math_max_ret, cleanup);
    local PropertyChangedSignal = u256:GetPropertyChangedSignal("Value");
    table.insert(u259, PropertyChangedSignal:Connect(function() -- Line: 1652
        -- upvalues: u256 (copy), cleanup (copy)
        if not u256.Value then
            cleanup();
        end;
    end));
    table.insert(u259, u251.CharacterRemoving:Connect(function(p261) -- Line: 1657
        -- upvalues: u252 (copy), cleanup (copy)
        if p261 == u252 then
            cleanup();
        end;
    end));
    table.insert(u259, Players.PlayerRemoving:Connect(function(p262) -- Line: 1662
        -- upvalues: u251 (copy), cleanup (copy)
        if p262 == u251 then
            cleanup();
        end;
    end));
end;

function u6.grantFastShotOnPass(p263: userdata?, p264: userdata?, p265: userdata?) -- Line: 1669
    -- upvalues: grantPassShot (copy)
    return grantPassShot("GrantedFastShot", "FastShot", p263, p264, p265);
end;

function u6.grantTwoStepsBehindShotOnPass(p266: userdata?, p267: userdata?, p268: userdata?) -- Line: 1673
    -- upvalues: grantPassShot (copy)
    return grantPassShot("GrantedTwoStepsBehindShot", "TwoStepsBehindShot", p266, p267, p268);
end;

function u6.grantNikoLionShotOnPass(p269: userdata?, p270: userdata?, p271: userdata?) -- Line: 1677
    -- upvalues: grantPassShot (copy)
    return grantPassShot("GrantedNikoLionShot", "NikoLionShot", p269, p270, p271, 2);
end;

return u6;