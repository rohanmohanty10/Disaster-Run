 
 

local Vector2_new_ret = Vector2.new(1616, 880);
local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui", 100);
local workspace_CurrentCamera = workspace.CurrentCamera;

local function getBox(p1) -- Line: 48
    return math.min(p1.X, p1.Y);
end;

local function getScreenRatio() -- Line: 53
    -- upvalues: workspace_CurrentCamera (copy), Vector2_new_ret (copy)
    local ViewportSize = workspace_CurrentCamera.ViewportSize;
    local v2 = Vector2_new_ret;

    return math.min(ViewportSize.X, ViewportSize.Y) / math.min(v2.X, v2.Y);
end;

local function tagRecursive(p3: userdata, u4: string, u5: string) -- Line: 59
    -- upvalues: CollectionService (copy), tagRecursive (copy)
    if p3:IsA(u4) then
        CollectionService:AddTag(p3, u5);
    end;

    for _, child in p3:GetChildren() do
        tagRecursive(child, u4, u5);
    end;

    p3.ChildAdded:Connect(function(p6) -- Line: 66
        -- upvalues: tagRecursive (ref), u4 (copy), u5 (copy)
        tagRecursive(p6, u4, u5);
    end);
end;

local function getInstancePosition(p7: userdata) -- Line: 72
    if p7:IsA("Part") then
        return p7.Position;
    end;

    if not p7:IsA("Model") then
        return Vector3.new(0, 0, 0);
    end;

    local BoundingBox, _ = p7:GetBoundingBox();

    return BoundingBox.Position;
end;

local u8 = {};
CollectionService:GetInstanceAddedSignal("ScreenGui"):Connect(function(p9: userdata) -- Line: 91
    -- upvalues: tagRecursive (copy)
    tagRecursive(p9, "UIStroke", "ScreenStroke");
end);
CollectionService:GetInstanceAddedSignal("ScreenStroke"):Connect(function(p10: userdata) -- Line: 96
    -- upvalues: u8 (copy), workspace_CurrentCamera (copy), Vector2_new_ret (copy)
    u8[p10] = p10.Thickness;
    local ViewportSize = workspace_CurrentCamera.ViewportSize;
    local v11 = Vector2_new_ret;
    p10.Thickness = p10.Thickness * (math.min(ViewportSize.X, ViewportSize.Y) / math.min(v11.X, v11.Y));
end);
workspace_CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() -- Line: 102, Name: updateScreenGuiStrokes
    -- upvalues: u8 (copy), workspace_CurrentCamera (copy), Vector2_new_ret (copy)
    for i, v in u8 do
        if i.Parent then
            local ViewportSize = workspace_CurrentCamera.ViewportSize;
            local v12 = Vector2_new_ret;
            i.Thickness = v * (math.min(ViewportSize.X, ViewportSize.Y) / math.min(v12.X, v12.Y));
        else
            u8[i] = nil;
        end;
    end;
end);
CollectionService:GetInstanceAddedSignal("Billboard"):Connect(function(u13: userdata) -- Line: 119
    -- upvalues: RunService (copy), workspace_CurrentCamera (copy), Vector2_new_ret (copy)
    local u14 = {};

    local function getUiStrokeFromInstance(p15: userdata) -- Line: 122
        -- upvalues: u14 (copy), getUiStrokeFromInstance (copy)
        if p15:IsA("UIStroke") then
            u14[p15] = p15.Thickness;
        end;

        for _, child in p15:GetChildren() do
            getUiStrokeFromInstance(child);
        end;

        p15.ChildAdded:Connect(getUiStrokeFromInstance);
    end;

    getUiStrokeFromInstance(u13);
    local u16 = tick();
    local u17 = nil;
    u17 = RunService.Heartbeat:Connect(function() -- Line: 135
        -- upvalues: u16 (ref), u13 (copy), u17 (ref), workspace_CurrentCamera (ref), u14 (copy), Vector2_new_ret (ref)
        if tick() - u16 > 1 then
            return;
        end;

        u16 = tick();

        if not u13.Parent then
            u17:Disconnect();

            return;
        end;

        local Adornee = u13.Adornee;
        local v18, v19, v20, v21;

        if Adornee then
            if Adornee:IsA("Part") then
                v18 = Adornee.Position;
            elseif Adornee:IsA("Model") then
                local BoundingBox, _ = Adornee:GetBoundingBox();
                v18 = BoundingBox.Position;
            else
                v18 = Vector3.new(0, 0, 0);
            end;

            if not v18 then
                v19 = u13.Parent;

                if v19:IsA("Part") then
                    v18 = v19.Position;
                elseif v19:IsA("Model") then
                    v20, v21 = v19:GetBoundingBox();
                    v18 = v20.Position;
                else
                    v18 = Vector3.new(0, 0, 0);
                end;
            end;
        else
            v19 = u13.Parent;

            if v19:IsA("Part") then
                v18 = v19.Position;
            elseif v19:IsA("Model") then
                v20, v21 = v19:GetBoundingBox();
                v18 = v20.Position;
            else
                v18 = Vector3.new(0, 0, 0);
            end;
        end;

        local Magnitude = (workspace_CurrentCamera.CFrame.Position - v18).Magnitude;
        local v22 = (u13:GetAttribute("Distance") or 10) / Magnitude;

        for i, v in u14 do
            if i.Parent then
                local ViewportSize = workspace_CurrentCamera.ViewportSize;
                local v23 = Vector2_new_ret;
                i.Thickness = v * v22 * (math.min(ViewportSize.X, ViewportSize.Y) / math.min(v23.X, v23.Y));
            else
                u14[i] = nil;
            end;
        end;
    end);
end);

return {
    TagScreenGui = function(p24, p25) -- Line: 175, Name: TagScreenGui
        -- upvalues: CollectionService (copy)
        if p25:IsA("ScreenGui") then
            CollectionService:AddTag(p25, "ScreenGui");
        end;
    end,

    TagBillboardGui = function(p26, p27) -- Line: 181, Name: TagBillboardGui
        -- upvalues: CollectionService (copy)
        if p27:IsA("BillboardGui") then
            CollectionService:AddTag(p27, "Billboard");
        end;
    end
};