  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
local TableUtil = require(PathShortcuts.KnitPath.TableUtil);
local u1 = nil;
local u2 = nil;
Knit.OnStart():andThen(function() -- Line: 9
    -- upvalues: u1 (ref), Knit (copy), PathShortcuts (copy), u2 (ref)
    u1 = Knit.GetService("PartyService");
    u2 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);
local v3 = {};
local u4 = {};
local u5 = {};

function v3.WeaponVisiblity(p6, p7, p8, p9) -- Line: 18
    local v10 = p6:FindFirstChild(p9 or "Arsenal");

    if not v10 then
        return;
    end;

    local v11 = typeof(p7) == "string" and { v10:FindFirstChild(p7) } or (typeof(p7) == "table" and p7 and p7 or { p7 });

    if v11 and v11[1] then
        local v12 = p8 and true or false;
        local v13 = v12 and 0 or 1;
        local v14 = {};

        for _, v in v11 do
            if typeof(v) == "string" then
                local v = v10:FindFirstChild(v) or v;
            end;

            if v:IsA("BasePart") and not v:FindFirstChildWhichIsA("BasePart") then
                v.Transparency = v13;
                table.insert(v14, v);
            else
                if v:IsA("BasePart") then
                    v.Transparency = v13;
                end;

                table.insert(v14, v);

                for _, child in v:GetChildren() do
                    if child:IsA("BasePart") then
                        child.Transparency = v13;
                    end;
                end;
            end;

            for _, descendant in v:GetDescendants() do
                if descendant:GetAttribute("EquipVisible") then
                    descendant.Enabled = v12;
                end;

                if descendant:GetAttribute("EmitVisible") and v12 then
                    descendant:Emit(descendant:GetAttribute("EmitAmount"));
                end;

                if descendant:GetAttribute("EmitInvisible") and not v12 then
                    descendant:Emit(descendant:GetAttribute("EmitAmount"));
                end;
            end;
        end;

        table.clear(v11);

        return v14;
    end;
end;

function v3.AvatarDirectCopy(p15) -- Line: 65
    return (p15:IsA("BodyColors") or (p15:IsA("Shirt") or (p15:IsA("ShirtGraphic") or (p15:IsA("CharacterMesh") or (p15:IsA("SpecialMesh") or p15:IsA("Pants")))))) and true or false;
end;

function v3.GetValidPartyMembers(p16) -- Line: 72
    -- upvalues: u1 (ref)
    if p16 and p16:IsA("Player") then
        local v17 = u1.GetParty(p16);
        local v18 = {};

        for _, v in v17 and v17:GetMembers() or {} do
            if v.Data.Ability.Value == 34 then
                table.insert(v18, v);
            end;
        end;

        return v18;
    end;
end;

function v3.IsMutualParty(p19, p20) -- Line: 87
    -- upvalues: u1 (ref)
    local v21;

    if p19 then
        v21 = u1.GetParty(p19);
    else
        v21 = p19;
    end;

    local v22;

    if p20 then
        v22 = u1.GetParty(p20);
    else
        v22 = p20;
    end;

    local v23 = v21 and v21:HasMember(p20);

    if v23 then
        v22 = v23;
    elseif v22 then
        v22 = v22:HasMember(p19);
    end;

    return v22;
end;

function v3.ValidateHealingTarget(p24, p25, p26) -- Line: 94
    return p24 and (p25 and (p24:IsDescendantOf(workspace) and (p25:IsDescendantOf(workspace) and p26 > (p24.Position - p25.Position).Magnitude))) and true or false;
end;

function v3.GetNearestTargetWithinHitbox(p27, p28, p29, p30, p31, p32) -- Line: 102
    -- upvalues: u2 (ref), TableUtil (copy)
    if not p27 then
        return;
    end;

    local v33 = u2.GetMetadata(p27);
    local v34 = nil;
    local v35 = {};
    local v36 = u2.Hitbox({
        Caster = p27,
        Stats = TableUtil.Reconcile(p29, {
            Origin = p30 and v33.MouseHit or v33.CFrame
        })
    });
    local v37 = 1000000;

    if v36 and #v36 > 0 then
        for _, v in v36 do
            local Character = v.Character;
            local v38;

            if Character then
                v38 = (Character.HumanoidRootPart.Position - (p31 == "Mouse" and v33.MouseHit.Position or v33.Position)).Magnitude;
            else
                v38 = Character;
            end;

            if p28 >= v38 and (Character and (v38 and v38 < v37)) then
                if p32 then
                    table.insert(v35, {
                        Target = Character,
                        Distance = v38
                    });
                    v34 = Character;
                    v37 = v38;
                else
                    v34 = Character;
                    v37 = v38;
                end;
            end;
        end;
    end;

    if not p32 then
        local v39;

        if v34 then
            v39 = v34:FindFirstChildOfClass("Humanoid");
        else
            v39 = v34;
        end;

        if v39 and (v34.Parent and (v39.Health ~= 0 and (p28 >= v37 and (v34:FindFirstChild("Head") and v34:FindFirstChild("Left Arm"))))) then
            return v34, v39;
        end;

        return nil;
    end;

    table.sort(v35, function(p40, p41) -- Line: 130
        return p40.Distance < p41.Distance;
    end);
    local v42 = {};

    for _, v in v35 do
        local Target = v.Target;
        local v43;

        if Target then
            v43 = Target:FindFirstChildOfClass("Humanoid");
        else
            v43 = Target;
        end;

        if v43 and (Target.Parent and (v43.Health ~= 0 and (p28 >= v.Distance and (Target:FindFirstChild("Head") and Target:FindFirstChild("Left Arm"))))) then
            table.insert(v42, {
                Target = Target,
                TargetHumanoid = v43
            });

            if p32 <= #v42 then
                break;
            end;
        end;
    end;

    return v42;
end;

function v3.Lerp(p44, p45, p46) -- Line: 155
    return p44 + (p45 - p44) * p46;
end;

function v3.ClearThread(p47) -- Line: 159
    if p47 and (coroutine.status(p47) ~= "running" and coroutine.status(p47) ~= "normal") then
        task.cancel(p47);
    end;
end;

function v3.GetFriends(u48) -- Line: 165
    -- upvalues: u4 (copy), u5 (copy)
    if u4[u48.UserId] then
        return u4[u48.UserId];
    end;

    if u5[u48.UserId] then
        table.insert(u5[u48.UserId], coroutine.running());

        return coroutine.yield();
    end;

    u5[u48.UserId] = {};
    local u49 = {};
    local success, result = pcall(function() -- Line: 173
        -- upvalues: u48 (copy), u49 (copy)
        local v50 = game.Players:GetFriendsAsync(u48.UserId);

        while true do
            for _, v in ipairs(v50:GetCurrentPage()) do
                table.insert(u49, v);
            end;

            if v50.IsFinished then
                return;
            end;

            v50:AdvanceToNextPageAsync();
        end;
    end);

    if success ~= true then
        for _, v in u5[u48.UserId] do
            task.spawn(v, false, result);
        end;

        u5[u48.UserId] = nil;

        return false, result;
    end;

    u4[u48.UserId] = u49;
    task.delay(600, function() -- Line: 193
        -- upvalues: u4 (ref), u48 (copy)
        u4[u48.UserId] = nil;
    end);

    for _, v in u5[u48.UserId] do
        task.spawn(v, u49);
    end;

    u5[u48.UserId] = nil;

    return u49;
end;

return v3;