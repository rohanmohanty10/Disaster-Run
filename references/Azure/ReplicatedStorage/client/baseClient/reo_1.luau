 
 

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
require(ReplicatedStorage.packets);
local actionUtil = require(ReplicatedStorage.util.actionUtil);
local Mouse = Players.LocalPlayer:GetMouse();
local workspace_CurrentCamera = workspace.CurrentCamera;
local script_Parent = script.Parent;

local function removeFromTable(p1, p2) -- Line: 18
    local table_find_ret = table.find(p1, p2);

    if table_find_ret then
        table.remove(p1, table_find_ret);
    end;

    return p1;
end;

local function getCopiedContent(u3, u4) -- Line: 26
    -- upvalues: script_Parent (copy)
    if not u3.character:GetAttribute((`copiedskill{u4}`)) then
        return;
    end;

    local Attribute = u3.character:GetAttribute((`copiedskill{u4}`));
    local table_unpack_ret, u5 = table.unpack(Attribute:split("|"));

    if table_unpack_ret == script.Name and u5 == tostring(u4) then
        return;
    end;

    if script_Parent:FindFirstChild(table_unpack_ret) then
        local v6 = require(script_Parent[table_unpack_ret]);

        if not v6[`skill{u5}`] then
            u3:senduse({ (`skill{u4}`) });

            return true;
        end;

        local v15 = setmetatable({}, {
            __index = function(p7, p8) -- Line: 40, Name: __index
                -- upvalues: u5 (copy), u4 (copy), u3 (copy)
                if p8 ~= "senduse" then
                    return u3[p8];
                end;

                local u9 = `skill{u5}`;

                return function(p10, p11, ...) -- Line: 43
                    -- upvalues: u9 (copy), u4 (ref), u3 (ref)
                    if typeof(p11) == "table" and (typeof(p11[1]) == "string" and p11[1]:find(u9, 1, true)) then
                        p11[1] = p11[1]:gsub(u9, (`skill{u4}`));
                    end;

                    return u3:senduse(p11, ...);
                end;
            end,

            __newindex = function(p12, p13, p14) -- Line: 53, Name: __newindex
                -- upvalues: u3 (copy)
                u3[p13] = p14;
            end
        });
        v6[`skill{u5}`](v15);

        return true;
    end;
end;

local u36 = {
    [1] = function(p16, p17) -- Line: 64
        local State = p16.human:GetState();
        local table_find_ret = table.find({ "Jumping", "Freefall" }, State.Name);
        local v18 = p16.humanoidRootPart.CFrame:VectorToObjectSpace(p16.human.MoveDirection);
        local v19 = math.round(v18.X) == 1 and "Right" or (math.round(v18.X) == -1 and "Left" or (math.round(v18.Z) == 1 and "Back" or "Front"));
        p16:senduse({ `skill{p17}`, table_find_ret, v19 });
    end,

    [2] = function(p20, p21) -- Line: 81
        -- upvalues: UserInputService (copy), workspace_CurrentCamera (copy), Mouse (copy), actionUtil (copy)
        local v22 = nil;
        local v23 = nil;
        local v24 = (UserInputService.GamepadEnabled or UserInputService.TouchEnabled) and Vector2.new(workspace_CurrentCamera.ViewportSize.X / 2, workspace_CurrentCamera.ViewportSize.Y / 2) or Vector2.new(Mouse.X, Mouse.Y, Mouse.Hit.p);

        if UserInputService.TouchEnabled then
            v24 = Vector2.new(workspace_CurrentCamera.ViewportSize.X / 2, workspace_CurrentCamera.ViewportSize.Y / 2);
        end;

        local Children = workspace.characters:GetChildren();
        local table_find_ret = table.find(Children, p20.character);

        if table_find_ret then
            table.remove(Children, table_find_ret);
        end;

        for _, v in ipairs(Children) do
            local HumanoidRootPart = v:FindFirstChild("HumanoidRootPart");
            local v25 = v:FindFirstChildWhichIsA("Humanoid");

            if HumanoidRootPart and (v25 and (v25.Health > 0 and (actionUtil.checksameTeam(p20.character, v) and (p20.humanoidRootPart.Position - HumanoidRootPart.Position).Magnitude < 165))) then
                local v26, v27 = workspace_CurrentCamera:WorldToScreenPoint(HumanoidRootPart.Position);
                local Vector2_new_ret = Vector2.new(v26.X, v26.Y);

                if v27 then
                    local Magnitude = (v24 - Vector2_new_ret).Magnitude;

                    if v22 and v23 then
                        if Magnitude < v23 then
                            v23 = Magnitude;
                            v22 = v;
                        end;
                    else
                        v23 = Magnitude;
                        v22 = v;
                    end;
                end;
            end;
        end;

        p20:senduse({ `skill{p21}`, v22 });
    end,

    [4] = function(p28, p29) -- Line: 119
        -- upvalues: UserInputService (copy), workspace_CurrentCamera (copy), Mouse (copy), actionUtil (copy)
        local v30 = nil;
        local v31 = nil;
        local v32 = (UserInputService.GamepadEnabled or UserInputService.TouchEnabled) and Vector2.new(workspace_CurrentCamera.ViewportSize.X / 2, workspace_CurrentCamera.ViewportSize.Y / 2) or Vector2.new(Mouse.X, Mouse.Y);
        local Children = workspace.characters:GetChildren();
        local table_find_ret = table.find(Children, p28.character);

        if table_find_ret then
            table.remove(Children, table_find_ret);
        end;

        for _, v in ipairs(Children) do
            local HumanoidRootPart = v:FindFirstChild("HumanoidRootPart");
            local v33 = v:FindFirstChildWhichIsA("Humanoid");

            if HumanoidRootPart and (v33 and v33.Health > 0) then
                if actionUtil.ingame(v) then
                    local v34, v35 = workspace_CurrentCamera:WorldToScreenPoint(HumanoidRootPart.Position);
                    local Vector2_new_ret = Vector2.new(v34.X, v34.Y);

                    if v35 then
                        local Magnitude = (v32 - Vector2_new_ret).Magnitude;

                        if v30 and v31 then
                            if Magnitude < v31 then
                                v31 = Magnitude;
                                v30 = v;
                            end;
                        else
                            v31 = Magnitude;
                            v30 = v;
                        end;
                    end;
                end;
            else
                local table_find_ret2 = table.find(v, nil);

                if table_find_ret2 then
                    table.remove(v, table_find_ret2);
                end;
            end;
        end;

        p28:senduse({ `skill{p29}`, v30 });
    end
};
local v37 = {
    __index = {}
};

for i = 1, 5 do
    v37[`skill{i}`] = function(p38) -- Line: 157
        -- upvalues: getCopiedContent (copy), i (copy), u36 (copy)
        if getCopiedContent(p38, i) then
            return;
        end;

        local v39 = u36[i];

        if v39 then
            v39(p38, i);

            return;
        end;

        p38:senduse({ (`skill{i}`) });
    end;

    local _ = i;
end;

return v37;