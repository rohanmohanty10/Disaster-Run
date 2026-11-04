 
 

local Entity = require(script.Parent.Entity);
local Events = require(script.Parent.Events);
local Holder = require(script.Parent.Holder);
require(script.Parent.Types);
local u1 = 0;
local u2 = {};
local u3 = {};
local u4 = {};
local u5 = {};
local u6 = {};

local function SetCFrame(p7: any, p8) -- Line: 16
    -- upvalues: Entity (copy)
    local v9 = Entity._GetRootPart(p7);

    if v9 then
        v9.CFrame = p8;

        if p7.isContextOwner then
            v9.AssemblyAngularVelocity = Vector3.new(0, 0, 0);
            v9.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
        end;
    end;
end;

local function ResolveWorldCFrame(p10) -- Line: 26
    -- upvalues: u1 (ref), u3 (copy), u4 (copy), u2 (copy), Entity (copy), Holder (copy), u5 (copy)
    local v11 = u1;

    if u3[p10] == v11 then
        return u4[p10];
    end;

    local _ = CFrame.identity;
    local v12 = p10;
    local v13 = 0;
    local v14;

    while true do
        if u3[p10] == v11 then
            v14 = u4[p10];
            break;
        end;

        if u2[p10] == v11 then
            v14 = Entity.GetAt(p10, Entity.GetTargetRenderTime(p10)) or (p10.latestCFrame or CFrame.identity);
            u3[p10] = v11;
            u4[p10] = v14;
            local v15 = Entity._GetRootPart(p10);

            if v15 then
                v15.CFrame = v14;

                if p10.isContextOwner then
                    v15.AssemblyAngularVelocity = Vector3.new(0, 0, 0);
                    v15.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
                end;
            end;

            break;
        end;

        u2[p10] = v11;
        local mountParentId = p10.mountParentId;

        if not mountParentId then
            if p10.isContextOwner then
                local PrimaryPart = Entity.GetPrimaryPart(p10);

                if PrimaryPart then
                    v14 = PrimaryPart.CFrame;
                else
                    v14 = p10.latestCFrame or CFrame.identity;
                end;
            else
                v14 = Entity.GetAt(p10, Entity.GetTargetRenderTime(p10)) or (p10.latestCFrame or CFrame.identity);
            end;

            u3[p10] = v11;
            u4[p10] = v14;
            break;
        end;

        local EntityFromId = Holder.GetEntityFromId(mountParentId);

        if not EntityFromId or EntityFromId.destroyed then
            v14 = Entity.GetAt(p10, Entity.GetTargetRenderTime(p10)) or (p10.latestCFrame or CFrame.identity);
            u3[p10] = v11;
            u4[p10] = v14;
            local v16 = Entity._GetRootPart(p10);

            if v16 then
                v16.CFrame = v14;

                if p10.isContextOwner then
                    v16.AssemblyAngularVelocity = Vector3.new(0, 0, 0);
                    v16.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
                end;
            end;

            break;
        end;

        v13 = v13 + 1;
        u5[v13] = p10;
        p10 = EntityFromId;
    end;

    local v17 = v14 or CFrame.identity;

    for i = v13, 1, -1 do
        local v18 = u5[i];
        v17 = v17 * (v18.mountOffset or CFrame.identity);
        u3[v18] = v11;
        u4[v18] = v17;
        local v19 = Entity._GetRootPart(v18);

        if v19 then
            v19.CFrame = v17;

            if v18.isContextOwner then
                v19.AssemblyAngularVelocity = Vector3.new(0, 0, 0);
                v19.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
            end;
        end;

        u5[i] = nil;
        local _ = i;
    end;

    if u3[v12] ~= v11 then
        u3[v12] = v11;
        u4[v12] = v17;
        local v20 = Entity._GetRootPart(v12);

        if v20 then
            v20.CFrame = v17;

            if v12.isContextOwner then
                v20.AssemblyAngularVelocity = Vector3.new(0, 0, 0);
                v20.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
            end;
        end;
    end;

    return u4[v12];
end;

Events.EntityAdded:Connect(function(p21) -- Line: 105
    -- upvalues: u6 (copy)
    if p21.mountParentId then
        u6[p21] = true;
    end;
end, true);
Events.EntityMountChanged:Connect(function(p22: any, p23: number?) -- Line: 111
    -- upvalues: u6 (copy)
    if p23 then
        u6[p22] = true;

        return;
    end;

    u6[p22] = nil;
end, true);
Events.EntityRemoved:Connect(function(p24) -- Line: 119
    -- upvalues: u3 (copy), u4 (copy), u6 (copy)
    u3[p24] = nil;
    u4[p24] = nil;
    u6[p24] = nil;
end, true);

return function() -- Line: 125, Name: ApplyMounts
    -- upvalues: u6 (copy), u3 (copy), u1 (ref), ResolveWorldCFrame (copy)
    debug.profilebegin("ApplyMounts");

    for i in u6 do
        if not i.destroyed and u3[i] ~= u1 then
            ResolveWorldCFrame(i);
        end;
    end;

    u1 = u1 + 1;
    debug.profileend();
end;