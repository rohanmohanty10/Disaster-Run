  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Trove = require(ReplicatedStorage.Packages.Trove);
local StatesController = require(ReplicatedStorage.Controllers.StatesController);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local u1 = require(ReplicatedStorage.Modules.ReplicatorClient).get("PlayerAbilityCooldowns");
local u2 = {};

local function OnPlayerAdded(p3: userdata) -- Line: 16
    -- upvalues: u2 (copy)
    u2[tostring(p3.UserId)] = p3;
end;

for _, v in Players:GetPlayers() do
    task.spawn(OnPlayerAdded, v);
end;

Players.PlayerAdded:Connect(OnPlayerAdded);
Players.PlayerRemoving:Connect(function(p4) -- Line: 24
    -- upvalues: u2 (copy)
    u2[tostring(p4.UserId)] = nil;
end);

return {
    hook = function(p5) -- Line: 31, Name: hook
        -- upvalues: AbilityUtils (copy), StatesController (copy), Trove (copy), ReplicatedStorage (copy), u1 (copy), u2 (copy)
        AbilityUtils.getCharacter();
        local CharacterEvents = StatesController.CharacterEvents;
        local v6 = Trove.new();
        local u7 = {};
        local u8 = false;

        local function buildGui(u9: userdata, p10: userdata) -- Line: 38
            -- upvalues: u7 (copy), ReplicatedStorage (ref)
            if u7[u9] then
                return u7[u9];
            end;

            if not (p10 and p10:FindFirstChild("HumanoidRootPart")) then
                return nil;
            end;

            local v11 = ReplicatedStorage.Assets.UI.CooldownVisionAiku:Clone();
            v11.Adornee = p10:FindFirstChild("HumanoidRootPart");
            v11.Parent = p10;

            for i = 1, 3 do
                local v12 = v11.SlotTemplate:Clone();
                v12.Name = `Slot{i}`;
                v12.LayoutOrder = i;
                v12.Parent = v11;
                local _ = i;
            end;

            v11.SlotTemplate:Destroy();
            u7[u9] = v11;
            u9.CharacterRemoving:Connect(function() -- Line: 60
                -- upvalues: u7 (ref), u9 (copy)
                u7[u9] = nil;
            end);

            return v11;
        end;

        v6:Add(function() -- Line: 67
            -- upvalues: u7 (copy)
            for _, v in u7 do
                v:Destroy();
            end;
        end);
        v6:Add(CharacterEvents.CustomEvent:Connect(function(p13) -- Line: 73
            -- upvalues: u8 (ref)
            if p13 == "CooldownMetavisionStart" then
                u8 = true;

                return;
            end;

            if p13 == "CooldownMetavisionEnd" then
                u8 = false;
            end;
        end));
        v6:Add(task.spawn(function(p14) -- Line: 81
            -- upvalues: u7 (copy), u8 (ref), u1 (ref), u2 (ref), buildGui (copy)
            while true do
                task.wait(0.2);

                for i, v in table.clone(u7) do
                    if not v:IsDescendantOf(workspace) then
                        u7[i] = nil;
                    end;

                    v.Enabled = u8;
                end;

                if u8 then
                    local v15 = tick();

                    for i, v in u1.Data do
                        local v16 = u2[i];

                        if v16 then
                            local v17 = buildGui(v16, v16.Character);

                            if v17 then
                                local v18 = v;

                                for i2 = 1, 3 do
                                    local v19 = v18[tostring(i2)];
                                    local v20 = v17:FindFirstChild((`Slot{i2}`));
                                    local v21;

                                    if v19 then
                                        v20.Visible = true;
                                        v20.TextLabel.Text = v19.name;
                                        local math_ceil_ret = math.ceil(v19.cooldown - v15);
                                        print(math_ceil_ret);

                                        if math_ceil_ret > 0 then
                                            v20.Timer.Text = `{math_ceil_ret}s`;
                                            v21 = i2;
                                        else
                                            v20.Timer.Text = "";
                                            v21 = i2;
                                        end;
                                    else
                                        v20.Visible = false;
                                        v21 = i2;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end));

        return v6, function(p22) -- Line: 130
        end;
    end
};