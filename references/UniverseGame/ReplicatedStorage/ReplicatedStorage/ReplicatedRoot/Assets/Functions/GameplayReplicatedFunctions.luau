  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
require(ReplicatedRoot.Core);
local DirectoryUtil = require(ReplicatedRoot.Libraries.Utility.DirectoryUtil);
local TableUtil = require(ReplicatedRoot.Libraries.Utility.TableUtil);
local SharedFunctionService = require(ReplicatedRoot.Services.SharedFunctionService);
local TagService = require(ReplicatedRoot.Services.TagService);
local CombatService = require(ReplicatedRoot.Services.CombatService);

local function GetTagsTable(p1) -- Line: 11
    local v2 = nil;

    if p1.Sequence then
        return p1.Sequence:GetState("_Tags");
    end;

    if p1.Call then
        if p1.Call.State._Tags == nil then
            p1.Call.State._Tags = {};
        end;

        return p1.Call.State._Tags;
    end;

    if p1.Move then
        if p1.Move.State._Tags == nil then
            p1.Move.State._Tags = {};
        end;

        v2 = p1.Move.State._Tags;
    end;

    return v2;
end;

local function GetInfo(p3, p4) -- Line: 29
    -- upvalues: DirectoryUtil (copy), TableUtil (copy)
    local _ = p3.Character;
    local Ability = p3.Ability;
    local Move = p3.Move;
    local Call = p3.Call;
    local Sequence = p3.Sequence;
    local v5 = typeof(p4) == "string" and {
        Info = p4
    } or p4;
    local Info = v5.Info;

    if not Info then
        if Sequence then
            Info = Sequence.Info or nil;
        else
            Info = nil;
        end;
    end;

    if typeof(Info) == "string" then
        Info = DirectoryUtil.Get({
            Path = Info,
            Roots = {
                { "@Info", Sequence and (Sequence.Info or {}) or {} },
                { "@Sequence", Sequence },
                { "@Call", Call },
                { "@Move", Move },
                { "@Ability", Ability }
            }
        });
    end;

    if Info ~= nil then
        local ExtraInfo = v5.ExtraInfo;

        if ExtraInfo then
            Info = TableUtil.Reconcile(ExtraInfo, Info);
        end;

        return Info;
    end;
end;

local u6 = {
    NoRotate = {
        Value = true
    },
    NoJump = {
        Value = true
    },
    NoRun = {
        Value = true
    },
    WalkSpeed = {
        Value = 0
    },
    MaxWalkSpeed = {
        Value = 8
    },
    WalkSpeedMultiplier = {
        Value = 1
    },
    JumpPower = {
        Value = 0
    },
    MaxJumpPower = {
        Value = 0
    },
    JumpPowerMultiplier = {
        Value = 1
    }
};

return {
    Stackable = function(p7, p8) -- Line: 98, Name: Stackable
        local _ = p7.Character;
        local _ = p7.Ability;
        local _ = p7.Move;
        local Call = p7.Call;
        local _ = p7.Sequence;

        if Call then
            Call.Replicated.Stackable = p8;
            Call:SetReplicated("Stackable", p8);
        end;
    end,

    Step = function(p9, p10) -- Line: 111, Name: Step
        -- upvalues: GetInfo (copy), CombatService (copy), TableUtil (copy)
        local Character = p9.Character;
        local _ = p9.Ability;
        local Move = p9.Move;
        local Call = p9.Call;
        local Sequence = p9.Sequence;
        local u11 = p9.Frame or os.clock() * 60;
        local v12 = Sequence.Collector or (Call.Collector or Move.Collector);
        local v13 = p10 or {};
        local v14 = GetInfo(p9, v13);

        if v14 == nil then
            return;
        end;

        local v15 = v13.Key or "Step";

        if v14[v15] then
            v14 = v14[v15];
        end;

        if v14 then
            CombatService.StepVelocity(TableUtil.Reconcile({
                Player = game.Players:GetPlayerFromCharacter(Character),
                Character = Character,
                Object = Character:FindFirstChild("HumanoidRootPart") or Character.PrimaryPart
            }, v14));

            if v14.Cleanup ~= false and Sequence then
                v12:Connect(Sequence.Stopped, function() -- Line: 141
                    -- upvalues: Sequence (copy), u11 (copy)
                    Sequence:CallFunction(u11, "CancelStep");
                end);
            end;
        end;
    end,

    CancelStep = function(p16, p17) -- Line: 149, Name: CancelStep
        -- upvalues: CombatService (copy)
        local Character = p16.Character;
        CombatService.StepVelocity({
            Cancel = true,
            Player = game.Players:GetPlayerFromCharacter(Character),
            Character = Character,
            Object = Character:FindFirstChild("HumanoidRootPart") or Character.PrimaryPart
        });
    end,

    Dash = function(u18, p19) -- Line: 159, Name: Dash
        -- upvalues: CombatService (copy), TableUtil (copy), SharedFunctionService (copy)
        local Character = u18.Character;
        local HumanoidRootPart = Character.HumanoidRootPart;
        local Sequence = u18.Sequence;
        local _ = u18.Collector;
        local Normal = p19.Normal;
        local Info = Sequence.Info;
        local EndSpeed = Info.EndSpeed;
        local MaxForce = Info.MaxForce;
        local Time = Info.Time;
        local u20 = Character.Humanoid.FloorMaterial ~= Enum.Material.Air;

        if u20 then
            MaxForce = MaxForce * Vector3.new(1, 0, 1);
        end;

        local u21 = CombatService.StepVelocity(TableUtil.Reconcile({
            Turn = true,
            Raycast = false,
            Character = Sequence.Character,
            Object = Sequence.RootPart,
            StartSpeed = Info.StartSpeed * Sequence:GetSpeed(),
            EndSpeed = EndSpeed * Sequence:GetSpeed(),
            Time = Time / Sequence:GetSpeed(),
            MaxForce = MaxForce,

            Normal = function() -- Line: 187, Name: Normal
                -- upvalues: HumanoidRootPart (copy), Normal (copy)
                return HumanoidRootPart.CFrame:VectorToWorldSpace(Normal);
            end
        }, Info));

        if Sequence then
            Sequence.Collector:Connect(Sequence.Updated, function() -- Line: 198
                -- upvalues: Character (copy), u20 (ref), u21 (copy)
                if Character.Humanoid.FloorMaterial ~= Enum.Material.Air and (not u20 and (u21 and u21:IsDescendantOf(game))) then
                    u20 = true;
                    u21:SetAttribute("MaxForceMultiplier", Vector3.new(1, 0, 1));
                end;
            end);
            Sequence.Collector:Connect(Sequence.Stopped, function() -- Line: 207
                -- upvalues: SharedFunctionService (ref), u18 (copy)
                SharedFunctionService.CallFunction("SetMovement", u18, {
                    NoRun = true,
                    MaxJumpPower = 0
                });
            end);
        end;

        SharedFunctionService.CallFunction("CreateTag", u18, {
            Name = "Dashing"
        });
    end,

    CreateTag = function(p22, p23) -- Line: 220, Name: CreateTag
        -- upvalues: TagService (copy), GetTagsTable (copy)
        local v24 = p22.Sequence.Collector or (p22.Call.Collector or p22.Move.Collector);
        local v25 = TagService.GetContainer(p22.Character);
        local v26 = GetTagsTable(p22);
        local v27 = p23 or {};
        local Name = v27.Name;
        local Value = v27.Value;
        local v28 = v27.Key or Name;

        if v26[v28] == nil then
            v26[v28] = v24:Construct(TagService.CreateTag, v25, Name, Value);
        end;
    end,

    RemoveTag = function(p29, p30) -- Line: 243, Name: RemoveTag
        -- upvalues: TagService (copy), GetTagsTable (copy)
        local v31 = p29.Sequence.Collector or (p29.Call.Collector or p29.Move.Collector);
        TagService.GetContainer(p29.Character);
        local v32 = GetTagsTable(p29);
        local v33 = p30 or {};
        local v34 = v33.Key or v33.Name;
        local v35 = v32[v34];

        if v35 ~= nil then
            v31:Remove(v35);
            v32[v34] = nil;
        end;
    end,

    SetTag = function(p36, p37) -- Line: 265, Name: SetTag
        -- upvalues: TagService (copy), GetTagsTable (copy)
        local Move = p36.Move;

        if not (p36.Sequence.Collector or p36.Call.Collector) then
            local _ = Move.Collector;
        end;

        TagService.GetContainer(p36.Character);
        local v38 = GetTagsTable(p36);
        local v39 = p37 or {};
        local Value = v39.Value;
        local v40 = v38[v39.Key or v39.Name];

        if v40 ~= nil then
            TagService.SetTagValue(v40, Value);
        end;
    end,

    ClearTags = function(p41, p42) -- Line: 287, Name: ClearTags
        -- upvalues: TagService (copy), GetTagsTable (copy)
        local v43 = p41.Sequence.Collector or (p41.Call.Collector or p41.Move.Collector);
        TagService.GetContainer(p41.Character);
        local v44 = GetTagsTable(p41);

        for i, v in pairs(v44) do
            v43:Remove(v);
            v44[i] = nil;
        end;
    end,

    SetMovement = function(p45, p46) -- Line: 303, Name: SetMovement
        -- upvalues: TagService (copy), GetTagsTable (copy), u6 (copy), TableUtil (copy)
        local _ = p45.Move;
        local _ = p45.Call;
        local _ = p45.Sequence;
        local Collector = p45.Collector;
        local v47 = TagService.GetContainer(p45.Character);
        local v48 = GetTagsTable(p45);

        if p46 == nil then
            for i, _ in pairs(v48) do
                local v49 = v48["Movement_" .. i];

                if v49 then
                    Collector:Remove(v49);
                end;
            end;

            return;
        end;

        for i, v in pairs(u6) do
            local v50 = v48["Movement_" .. i];

            if v50 and not v50:IsDescendantOf(game) then
                v50 = nil;
            end;

            local v51 = p46[i];

            if v51 ~= nil then
                local v52 = typeof(v51) ~= "table" and {
                    Value = v51
                } or v51;
                v51 = TableUtil.Reconcile(v52, v);
            end;

            if v50 and not v51 then
                v50:Destroy();
            elseif not v50 and v51 then
                local CreateTag = TagService.CreateTag;
                local v53;

                if typeof(v51) == "table" then
                    v53 = v51.StartValue or v51.Value;
                else
                    v53 = false;
                end;

                v50 = Collector:Construct(CreateTag, v47, i, v53);
                v48["Movement_" .. i] = v50;
            end;

            if v50 and v51 then
                if v51.EasingStyle then
                    TagService.TweenTagValue(v50, v51);
                else
                    TagService.SetTagValue(v50, v51.Value or v50.Value);
                end;
            end;
        end;
    end
};