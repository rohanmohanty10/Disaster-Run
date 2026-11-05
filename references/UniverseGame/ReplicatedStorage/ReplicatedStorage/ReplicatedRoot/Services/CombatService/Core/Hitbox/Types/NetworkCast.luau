  

 

local v1 = {};
local HitboxFunction = game.ReplicatedStorage.Remotes.HitboxFunction;

function v1.Cast(u2) -- Line: 5
    -- upvalues: HitboxFunction (copy)
    local HitboxInfo = u2.HitboxInfo;
    local _ = u2.HitboxType;
    local v3 = HitboxInfo.MaxYield or 1;
    local u4 = game.Players:GetPlayerFromCharacter(u2.Caster);
    local u5 = nil;
    local u6 = {
        Info = HitboxInfo
    };

    if u4 then
        task.spawn(function() -- Line: 19
            -- upvalues: u5 (ref), HitboxFunction (ref), u4 (copy), u2 (copy), u6 (copy)
            u5 = HitboxFunction:InvokeClient(u4, "NetworkCast", u2, u6);
        end);
        local v7 = os.time();

        while os.time() - v7 <= v3 and not u5 do
            task.wait();
        end;

        u5 = type(u5) ~= "table" and {} or u5;
    end;

    return u5;
end;

function v1.Validate(p8, p9) -- Line: 32
    local v10 = type(p8) ~= "table" and {} or p8;
    local Caster = p9.Caster;
    local HitboxInfo = p9.HitboxInfo;

    if not (Caster and (Caster:IsDescendantOf(workspace) and Caster:FindFirstChild("HumanoidRootPart"))) then
        return v10;
    end;

    local v11 = p9.Size or HitboxInfo.Size;

    if typeof(v11) == "Vector3" then
        v11 = v11.Magnitude;
    end;

    local v12 = HitboxInfo.MaxDistance or v11 * (HitboxInfo.Tolerance or 1);
    local HumanoidRootPart = Caster.HumanoidRootPart;
    local v13 = {};

    for _, v in ipairs(v10) do
        if v and (typeof(v) == "Instance" and (v:IsA("BasePart") and (v:IsDescendantOf(workspace.Living) and (v.Parent.Parent == workspace.Living and (HumanoidRootPart.CFrame.Position - v.CFrame.Position).Magnitude <= v12)))) then
            table.insert(v13, v);
        end;
    end;

    return v13;
end;

return v1;