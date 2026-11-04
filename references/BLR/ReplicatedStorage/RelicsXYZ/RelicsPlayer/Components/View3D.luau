  

local Parent = script.Parent.Parent;
local Hooks = Parent.Hooks;
local Shared = Parent.Parent.Shared;
local React = require(Shared.React);
local ReactRoblox = require(Shared.ReactRoblox);
local HttpService = game:GetService("HttpService");
local RunService = game:GetService("RunService");
local useAttribute = require(Hooks.useAttribute);
require(Hooks.useHeartbeat);
local useSignal = require(Hooks.useSignal);
local useClock = require(Hooks.useClock);
local useEffect = React.useEffect;
local useRef = React.useRef;
local CFrame_Angles_ret = CFrame.Angles(0, 3.141592653589793, 0);

local function getAbsoluteExtents(p1: userdata) -- Line: 50
    if not p1:IsA("Model") then
        return not p1:IsA("BasePart") and Vector3.new(0, 0, 0) or p1.Size;
    end;

    local Pivot = p1:GetPivot();
    local v2 = (-1 / 0);
    local v3 = (-1 / 0);
    local v4 = (1 / 0);
    local v5 = (1 / 0);
    local v6 = (1 / 0);
    local v7 = (-1 / 0);

    for _, descendant in p1:GetDescendants() do
        if descendant:IsA("BasePart") then
            local CFrame2 = descendant.CFrame;
            local v8 = descendant.Size / 2;
            local v9 = { CFrame2:PointToWorldSpace(-v8), CFrame2:PointToWorldSpace(v8) };

            for _, v in ipairs(v9) do
                local v10 = Pivot:PointToObjectSpace(v);
                v4 = math.min(v4, v10.X);
                v5 = math.min(v5, v10.Y);
                v6 = math.min(v6, v10.Z);
                v7 = math.max(v7, v10.X);
                v2 = math.max(v2, v10.Y);
                v3 = math.max(v3, v10.Z);
            end;
        elseif descendant:IsA("Attachment") then
            local v11 = Pivot:PointToObjectSpace(descendant.WorldPosition);
            v4 = math.min(v4, v11.X);
            v5 = math.min(v5, v11.Y);
            v6 = math.min(v6, v11.Z);
            v7 = math.max(v7, v11.X);
            v2 = math.max(v2, v11.Y);
            v3 = math.max(v3, v11.Z);
        end;
    end;

    return Vector3.new(v7 - v4, v2 - v5, v3 - v6);
end;

local function getDepthForWidth(p12, p13: number, p14: number, p15: number?) -- Line: 103
    local v16 = p12.X / p12.Y;

    if v16 ~= v16 then
        return 0;
    end;

    local math_max_ret = math.max(1, p12.X);
    local v17 = p15 or math.max(1, p12.Y);
    local v18 = math.rad(p13) / 2;
    local v19 = v16 * math.tan(v18);

    return -(math_max_ret * -0.5 * p14 / (v17 * v19));
end;

return function(u20) -- Line: 119, Name: View3D
    -- upvalues: useRef (copy), useAttribute (copy), useEffect (copy), React (copy), useSignal (copy), HttpService (copy), getAbsoluteExtents (copy), RunService (copy), useClock (copy), CFrame_Angles_ret (copy), ReactRoblox (copy)
    local Model = u20.Model;
    local u21 = useRef(nil);
    local u22 = useRef(nil);
    local u23 = useRef(nil);
    local u24 = u20.ViewOffset or CFrame.identity;

    if u20.ViewportRef then
        u23 = u20.ViewportRef;
    end;

    local u26 = useAttribute(Model, "ZoomScale", function(p25) -- Line: 130
        return typeof(p25) == "number" and p25 and p25 or nil;
    end) or (u20.ZoomScale or 1);
    local v28 = useAttribute(Model, "Ambient", function(p27) -- Line: 134
        return typeof(p27) == "Color3" and p27 and p27 or nil;
    end) or (u20.Ambient or Color3.fromHex("#afafaf"));
    useEffect(function() -- Line: 138
        -- upvalues: Model (copy), u24 (copy)
        if Model then
            Model:PivotTo(u24);
        end;
    end, { Model, u24 });
    local u29 = u20.FieldOfView or 70;
    local u30, u31 = React.useState(0);
    local ModelSize = u20.ModelSize;
    local u32 = nil;
    local v33;

    if Model then
        v33 = Model.DescendantAdded;
    else
        v33 = Model;
    end;

    useSignal(v33, function() -- Line: 152
        -- upvalues: u32 (ref), u31 (copy)
        if u32 then
            return;
        end;

        u32 = task.defer(function() -- Line: 157
            -- upvalues: u32 (ref), u31 (ref)
            u32 = nil;
            u31((0 / 0));
        end);
    end);
    local v34;

    if Model then
        v34 = Model.DescendantRemoving;
    else
        v34 = Model;
    end;

    useSignal(v34, function() -- Line: 163
        -- upvalues: u32 (ref), u31 (copy)
        if u32 then
            return;
        end;

        u32 = task.defer(function() -- Line: 168
            -- upvalues: u32 (ref), u31 (ref)
            u32 = nil;
            u31((0 / 0));
        end);
    end);
    useEffect(function() -- Line: 174
        -- upvalues: u23 (ref), u21 (copy), Model (copy), u20 (copy)
        local current = u23.current;
        local current2 = u21.current;

        if Model then
            pcall(function() -- Line: 179
                -- upvalues: Model (ref), u20 (ref), current2 (copy), current (copy)
                Model.Parent = u20.RenderInWorld and current2 or current;
            end);
        end;
    end, { Model, u20.RenderInWorld });
    useEffect(function() -- Line: 188
        -- upvalues: u23 (ref), Model (copy), ModelSize (copy), u29 (copy), u31 (copy)
        local current = u23.current;

        if Model and current then
            local v35;

            if ModelSize then
                v35 = ModelSize;
            elseif Model:IsA("Model") then
                v35 = select(2, Model:GetBoundingBox());
            else
                v35 = not Model:IsA("BasePart") and Vector3.new(0, 0, 0) or Model.Size;
            end;

            local math_max_ret = math.max(v35.X, v35.Y, v35.Z);
            local AbsoluteSize = current.AbsoluteSize;
            local v36 = u29;
            local v37 = AbsoluteSize.X / AbsoluteSize.Y;
            local v38;

            if v37 == v37 then
                local math_max_ret2 = math.max(1, AbsoluteSize.X);
                local math_max_ret3 = math.max(1, AbsoluteSize.Y);
                local v39 = math.rad(v36) / 2;
                local v40 = v37 * math.tan(v39);
                v38 = -(math_max_ret2 * -0.5 * math_max_ret / (math_max_ret3 * v40));
            else
                v38 = 0;
            end;

            u31(v38);
        end;
    end, {
        u29,
        Model,
        u30,
        ModelSize
    });
    React.useEffect(function() -- Line: 214
        -- upvalues: Model (copy), u20 (copy), HttpService (ref), getAbsoluteExtents (ref), RunService (ref), u23 (ref), u26 (copy)
        if Model and u20.RenderInWorld then
            local workspace_CurrentCamera = workspace.CurrentCamera;
            local u41 = HttpService:GenerateGUID(false);
            local u42 = getAbsoluteExtents(Model);
            RunService:BindToRenderStep(u41, 1000, function() -- Line: 223
                -- upvalues: u23 (ref), u42 (copy), workspace_CurrentCamera (copy), u26 (ref), Model (ref)
                local current = u23.current;

                if not current then
                    return;
                end;

                local AbsoluteSize = current.AbsoluteSize;
                local v43 = current.AbsolutePosition + AbsoluteSize / 2;
                local math_max_ret = math.max(u42.X, u42.Y, u42.Z);
                local math_min_ret = math.min(AbsoluteSize.X, AbsoluteSize.Y);
                local ViewportSize = workspace_CurrentCamera.ViewportSize;
                local v44 = ViewportSize.X / ViewportSize.Y;
                local v45 = math.abs(v43.X / ViewportSize.X - 0.5) * 2;
                local ViewportSize2 = workspace_CurrentCamera.ViewportSize;
                local FieldOfView = workspace_CurrentCamera.FieldOfView;
                local v46 = ViewportSize2.X / ViewportSize2.Y;
                local v47;

                if v46 == v46 then
                    local math_max_ret2 = math.max(1, ViewportSize2.X);
                    local v48 = math_min_ret or math.max(1, ViewportSize2.Y);
                    local v49 = math.rad(FieldOfView) / 2;
                    local v50 = v46 * math.tan(v49);
                    v47 = -(math_max_ret2 * -0.5 * math_max_ret / (v48 * v50));
                else
                    v47 = 0;
                end;

                local v51 = workspace_CurrentCamera:ScreenPointToRay(v43.X, v43.Y, v47 * u26 * (1 + (v44 - 1) * v45));
                Model:PivotTo((CFrame.lookAlong(v51.Origin, v51.Direction, workspace_CurrentCamera.CFrame.UpVector)));
            end);

            return function() -- Line: 258
                -- upvalues: RunService (ref), u41 (copy)
                RunService:UnbindFromRenderStep(u41);
            end;
        end;
    end, { Model, u20.RenderInWorld });
    useClock(5, function() -- Line: 266
        -- upvalues: u22 (copy), u23 (ref), Model (copy), CFrame_Angles_ret (ref), u30 (copy), u26 (copy)
        local current = u22.current;

        if current and (u23.current and Model) then
            current.CFrame = CFrame_Angles_ret - CFrame_Angles_ret.LookVector * u30 * u26;
        end;
    end, { u26, u30, u29 });
    local createElement = React.createElement;
    local v52 = {
        BackgroundTransparency = 1,
        Ambient = v28,
        LightColor = u20.LightColor or Color3.fromHex("#ffffff"),
        BackgroundColor3 = u20.EdgeColor or Color3.fromHex("#2e2e2e"),
        Size = u20.Size or UDim2.fromScale(1, 1),
        ImageTransparency = u20.Transparency,
        CurrentCamera = u22,
        AnchorPoint = u20.AnchorPoint,
        LayoutOrder = u20.LayoutOrder,
        ImageColor3 = u20.TintColor,
        Position = u20.Position,
        ref = u23
    };
    local v53 = {
        Camera = React.createElement("Camera", {
            FieldOfView = u20.FieldOfView,
            ref = u22
        })
    };
    local v54 = u20.RenderInWorld and ReactRoblox.createPortal({
        Render = React.createElement("Folder", {
            Archivable = false,
            ref = u21
        })
    }, workspace.CurrentCamera);
    v53.Portal = v54;

    return createElement("ViewportFrame", v52, v53);
end;