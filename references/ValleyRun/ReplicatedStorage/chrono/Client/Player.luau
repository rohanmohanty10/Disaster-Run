 

 

local Warn = require(script.Parent.Parent.Shared.Warn);
local Events = require(script.Parent.Parent.Shared.Events);
local Entity = require(script.Parent.Parent.Shared.Entity);
local Holder = require(script.Parent.Parent.Shared.Holder);
require(script.Parent.Parent.Shared.Types);
local Config = require(script.Parent.Parent.Shared.Config);
local LocalPlayer = game:GetService("Players").LocalPlayer;
Events.PlayerCharacterRegistered:Connect(function(u1: userdata, p2: any) -- Line: 10
    -- upvalues: Config (copy), Entity (copy), Warn (copy), LocalPlayer (copy)
    if Config._GetConfig("PLAYER_REPLICATION") ~= "AUTOMATIC" then
        return;
    end;

    if Entity.GetModelReplicationType(p2) ~= "CUSTOM" then
        return;
    end;

    if not p2.model then
        return Warn.high((`No model found for {u1}`));
    end;

    if p2.model then
        if not p2.model:IsA("Model") then
            return Warn.high((`Model for {u1} is not a Model instance.`));
        end;

        u1.Character = p2.model;
    end;

    local function newModel(p3: any, p4: userdata?) -- Line: 29
        -- upvalues: Warn (ref), u1 (copy), LocalPlayer (ref)
        if not p4 then
            return;
        end;

        if not p4:IsA("Model") then
            Warn.high((`Model for {u1} is not a Model instance.`));

            return;
        end;

        LocalPlayer.Character = p3.model;
        local CFrame = workspace.CurrentCamera.CFrame;
        workspace.CurrentCamera.CameraSubject = p3.model:FindFirstChildWhichIsA("Humanoid") or p3.model.PrimaryPart;
        workspace.CurrentCamera.CFrame = CFrame;

        for _, v in p4:QueryDescendants("LocalScript") do
            if v:IsA("LocalScript") and v.Disabled == false then
                v.Disabled = true;
                v.Disabled = false;
            end;
        end;
    end;

    if LocalPlayer == u1 then
        Entity.GetEvent(p2, "ModelChanged"):Connect(newModel);
        newModel(p2, p2.model);
    end;
end);
local Death = script.Parent.Parent.Shared.Remotes.Death;
Config._WaitForLock(function() -- Line: 56
    -- upvalues: Config (copy), Events (copy), Death (copy), Entity (copy)
    if Config._GetConfig("PLAYER_REPLICATION") ~= "AUTOMATIC" then
        return;
    end;

    Events.PlayerOwnedAdded:Connect(function(p5: userdata, u6: any) -- Line: 60
        -- upvalues: Death (ref), Entity (ref)
        local u7 = nil;

        local function v11(p8: any, p9: userdata?) -- Line: 62
            -- upvalues: u7 (ref), u6 (copy), Death (ref)
            if u7 then
                u7:Disconnect();
                u7 = nil;
            end;

            if not (p9 and (u6.isContextOwner and p9:IsA("Model"))) then
                return;
            end;

            local v10 = p9:FindFirstChildWhichIsA("Humanoid");

            if v10 then
                u7 = v10.Died:Connect(function() -- Line: 74
                    -- upvalues: u6 (ref), Death (ref)
                    if not u6.isContextOwner then
                        return;
                    end;

                    Death:FireServer(u6.id);
                end);
            end;
        end;

        Entity.GetEvent(u6, "ModelChanged"):Connect(v11);
        v11(u6, u6.model);
        Entity.GetEvent(u6, "Destroying"):Connect(function() -- Line: 84
            -- upvalues: u7 (ref)
            if u7 then
                u7:Disconnect();
                u7 = nil;
            end;
        end);
    end);
end);
Death.OnClientEvent:Connect(function(p12) -- Line: 93
    -- upvalues: Holder (copy)
    local EntityFromId = Holder.GetEntityFromId(p12);

    if not EntityFromId then
        return;
    end;

    if EntityFromId.isContextOwner then
        return;
    end;

    local model = EntityFromId.model;

    if model then
        task.wait();
        local v13 = model:FindFirstChildWhichIsA("Humanoid");

        if v13 and v13:GetState() ~= Enum.HumanoidStateType.Dead then
            v13.Health = 0;
            v13.Health = 10;
            v13.Health = 0;
        end;
    end;
end);

return nil;