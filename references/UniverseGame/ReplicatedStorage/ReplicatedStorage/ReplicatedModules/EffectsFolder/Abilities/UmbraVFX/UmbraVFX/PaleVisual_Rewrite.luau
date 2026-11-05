  

 

local v1 = {};
local Util = require(script.Util);
v1.Util = Util;
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
local ParticleHandler = require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u2 = Random.new();

function v1.PlayVisual(u3) -- Line: 23
    -- upvalues: Util (copy), RunService (copy)
    Util.lfThread();
    Util.desynchronize();

    if not (u3 and (u3.Directory and u3.Directory:IsA("Instance"))) then
        warn((`PlayVisual : {u3 and "Directory" or "Data"} Can't Be Found.`));
        Util.synchronize();

        return true;
    end;

    local v4 = {
        Lifetime = 0
    };
    Util.synchronize();
    local u5 = u3.Parent and u3.Directory:Clone() or u3.Directory;

    if u3.Parent then
        table.insert(v4, u5);
        u5.Parent = u3.Parent;
    end;

    if u3.Offset then
        if u5:IsA("BasePart") or u5:IsA("Attachment") then
            u5[typeof(u3.Offset) == "Vector3" and "Position" or "CFrame"] = u3.Offset;
        elseif u5:IsA("Model") then
            local v6;

            if typeof(u3.Offset) == "Vector3" then
                v6 = CFrame.new(u3.Offset);
            else
                v6 = u3.Offset;
            end;

            u5:PivotTo(v6);
        end;
    end;

    if u3.WeldPart then
        if u5:IsA("BasePart") then
            local Weld = Instance.new("Weld");
            Weld.Parent = u5;
            Weld.Enabled = true;
            Weld.Part0 = u3.WeldPart;
            Weld.Part1 = u5;

            if u3.Offset then
                local v7;

                if typeof(u3.Offset) == "Vector3" then
                    v7 = CFrame.new(u3.Offset);
                else
                    v7 = u3.Offset;
                end;

                Weld.C1 = v7;
            end;
        elseif u5:IsA("Model") then
            table.insert(v4, RunService.PreRender:Connect(function() -- Line: 72
                -- upvalues: Util (ref), u3 (copy), u5 (copy)
                Util.desynchronize();
                local CFrame2 = u3.WeldPart.CFrame;

                if u3.Offset then
                    local v8;

                    if typeof(u3.Offset) == "Vector3" then
                        v8 = CFrame.new(u3.Offset);
                    else
                        v8 = u3.Offset;
                    end;

                    CFrame2 = CFrame2 * v8;
                end;

                Util.synchronize();
                u5:PivotTo(CFrame2);
            end));
        end;
    end;

    Util.desynchronize();
    local v9;

    if u3.SearchType and u3.SearchType == "Children" then
        v9 = u5:GetChildren();
    else
        v9 = u5:GetDescendants();
    end;

    if u5:IsA("ParticleEmitter") then
        table.insert(v9, u5);
    end;

    for _, v in ipairs(v9) do
        Util.desynchronize();

        if v:IsA("ParticleEmitter") then
            if v.Lifetime.Max > v4.Lifetime then
                v4.Lifetime = v.Lifetime.Max;
            end;

            if u3.Type and u3.Type == "Enable" then
                Util.synchronize();
                v.Enabled = true;
                task.delay(u3.Duration or 1, function() -- Line: 102
                    -- upvalues: v (copy)
                    v.Enabled = false;
                end);
            else
                local u10 = v:GetAttribute("EmitCount") or v.Rate;
                local u11 = v:GetAttribute("EmitDelay");
                task.spawn(function() -- Line: 109
                    -- upvalues: u11 (copy), Util (ref), v (copy), u10 (copy)
                    if u11 then
                        task.wait(u11);
                    end;

                    Util.synchronize();
                    v:Emit(u10);
                end);
            end;
        end;
    end;

    Util.synchronize();
    task.delay(v4.Lifetime + (u3.Duration or 0), Util.disconnectTable, v4);

    if u3._desynchronize then
        Util.desynchronize();
    end;

    return u5;
end;

function v1.Transparency(u12) -- Line: 130
    -- upvalues: Util (copy), TweenService (copy)
    Util.lfThread();
    Util.desynchronize();

    if not (u12 and (u12.Directory and u12.Directory:IsA("Instance"))) then
        warn((`Transparency : {u12 and "Directory" or "Data"} Can't Be Found.`));
        Util.synchronize();

        return true;
    end;

    local u13 = {};
    local v14;

    if typeof(u12.Ignore) == "Instance" then
        v14 = { u12.Ignore };
    else
        v14 = u12.Ignore or {};
    end;

    u13.Ignore = v14;
    u13.Transparency = {};
    u13.Enabled = {};
    local v15 = u12.Directory:GetDescendants();
    table.insert(v15, u12.Directory);

    for _, v in ipairs(v15) do
        if not table.find(u13.Ignore, v) and (not v:HasTag("IgnoreTransparency") and v.Name ~= "HumanoidRootPart") then
            Util.synchronize();

            if table.find({ "ParticleEmitter", "Beam", "Trail", "PointLight", "SpotLight" }, v.ClassName) and v.Enabled then
                v.Enabled = false;
                table.insert(u13.Enabled, v);
            end;

            if table.find({ "Decal", "Texture", "Part", "MeshPart", "UnionOperation" }, v.ClassName) then
                u13.Transparency[v] = v.Transparency;

                if u12.TweenIn then
                    if typeof(u12.TweenIn) == "number" then
                        task.delay(u12.TweenIn, function() -- Line: 176
                            -- upvalues: v (copy), u12 (copy)
                            v.Transparency = u12.Transparency or 1;
                        end);
                    else
                        TweenService:Create(v, u12.TweenIn, {
                            Transparency = u12.Transparency or 1
                        }):Play();
                    end;
                else
                    v.Transparency = u12.Transparency or 1;
                end;
            end;
        end;
    end;

    Util.desynchronize();

    if u12.Type == "Attribute" and u12.Attribute then
        u12.Directory:GetAttributeChangedSignal(u12.Attribute):Wait();
    else
        task.wait(u12.Duration or 1);
    end;

    for _, v in ipairs(v15) do
        if not table.find(u13.Ignore, v) and (not v:HasTag("IgnoreTransparency") and v.Name ~= "HumanoidRootPart") then
            Util.synchronize();

            if table.find(u13.Enabled, v) then
                v.Enabled = true;
            end;

            if u13.Transparency[v] then
                if u12.TweenOut then
                    if typeof(u12.TweenOut) == "number" then
                        task.delay(u12.TweenOut, function() -- Line: 206
                            -- upvalues: v (copy), u13 (copy)
                            v.Transparency = u13.Transparency[v];
                        end);
                    else
                        TweenService:Create(v, u12.TweenOut, {
                            Transparency = u13.Transparency[v]
                        }):Play();
                    end;
                else
                    v.Transparency = u13.Transparency[v];
                end;
            end;
        end;
    end;

    Util.disconnectTable(u13);

    if not u12._desynchronize then
        Util.synchronize();
    end;

    return true;
end;

function v1.BezierCurve(u16) -- Line: 224
    -- upvalues: Util (copy), ParticleHandler (copy), u2 (copy)
    Util.lfThread();
    Util.desynchronize();

    if not (u16 and (Util.getOrigin(u16) and u16.Object)) then
        warn((`BezierCurve : {u16 and (Util.getOrigin(u16) and "Origin" or "Object") or "Data"} Can't Be Found.`));
        Util.synchronize();

        return true;
    end;

    if not u16.Points or #u16.Points <= 1 then
        u16.Points = { {
                X = { -1, 1 },
                Y = { -1, 1 },
                Z = { -1, 1 }
            }, {
                X = { -7, 7 },
                Y = { -7, 7 },
                Z = { -7, 7 }
            }, {
                X = { -5, 5 },
                Y = { -5, 5 },
                Z = { -5, 5 }
            } };
    end;

    for _ = 1, u16.Amount or 1 do
        Util.desynchronize();

        if not Util.getOrigin(u16) then
            warn("BezierCurve : Origin Can\'t Be Found.");
            break;
        end;

        task.spawn(function() -- Line: 275
            -- upvalues: Util (ref), u16 (copy), ParticleHandler (ref), u2 (ref)
            Util.synchronize();
            local v17 = u16.Object:Clone();

            if u16.HSVShift then
                ParticleHandler.HSVShiftParticles(v17, u16.HSVShift);
            end;

            v17.Parent = u16.Parent or workspace.CurrentCamera;

            for _, descendant in ipairs(v17:GetDescendants()) do
                if table.find({ "ParticleEmitter", "Beam", "Trail", "PointLight", "SpotLight" }, descendant.ClassName) then
                    descendant.Enabled = true;
                end;
            end;

            task.delay((u16.Duration or 0.5) + Util.getLifetime(v17), v17.Destroy, v17);
            Util.desynchronize();
            Util.getOrigin(u16);
            local v18 = {};
            local v19 = {};

            for i, v in ipairs(u16.Points) do
                if typeof(v) == "table" then
                    local v20 = u2:NextNumber(v.X[1], v.X[2]);
                    local v21 = u2:NextNumber(v.Y[1], v.Y[2]);
                    v18[i] = Vector3.new(v20, v21, u2:NextNumber(v.Z[1], v.Z[2]));
                    v19[i] = true;
                else
                    v18[i] = v;
                end;
            end;

            for i, v in ipairs(v18) do
                if v19[i] then
                    v18[i] = (Util.getOrigin(u16) + v) * (u16.Multiplier or 1);
                else
                    v18[i] = v;
                end;
            end;

            local v22 = math.ceil((u16.Duration or 0.5) * (u16.FrameRate or 60));

            for i = 1, v22 do
                Util.desynchronize();

                if not (v17:IsDescendantOf(game) and Util.getOrigin(u16)) then
                    break;
                end;

                Util.synchronize();
                v17.Position = Util.bezier(i / v22, v18);
                task.wait(1 / (u16.FrameRate or 60));
            end;

            if not v17:IsDescendantOf(game) then
                return;
            end;

            Util.desynchronize();

            for _, descendant in ipairs(v17:GetDescendants()) do
                Util.desynchronize();

                if table.find({ "ParticleEmitter", "Beam", "Trail", "PointLight", "SpotLight" }, descendant.ClassName) then
                    Util.synchronize();
                    descendant.Enabled = false;
                end;
            end;
        end);
        task.wait(u16.Delay);
    end;

    if not u16._desynchronize then
        Util.synchronize();
    end;

    return true;
end;

function v1.ScreenPulse(p23) -- Line: 357
    -- upvalues: Util (copy), Players (copy), TweenService (copy)
    Util.lfThread();
    Util.desynchronize();

    if p23.ImageId and typeof(p23.ImageId) == "number" then
        p23.ImageId = "rbxassetid://" .. p23.ImageId;
    end;

    Util.synchronize();
    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Parent = Players.LocalPlayer.PlayerGui;
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.DisplayOrder = p23.DisplayOrder or 0;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Parent = ScreenGui;
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Size = UDim2.fromScale(1, 1);
    ImageLabel.Image = p23.ImageId or "rbxassetid://78856629448747";
    ImageLabel.ImageColor3 = p23.Color or Color3.fromRGB(255, 255, 255);
    ImageLabel.ImageTransparency = p23.StartTransparency or 0;
    TweenService:Create(ImageLabel, p23.TweenInfo or TweenInfo.new(p23.Duration or 1, Enum.EasingStyle.Sine), p23.TweenProperty or {
        ImageTransparency = p23.PostTransparency or 1
    }):Play();
    Util.desynchronize();
    local v24 = p23.TweenInfo and p23.TweenInfo.Time + (p23.TweenInfo.DelayTime or 0) or (p23.Duration or 1);
    Util.synchronize();
    task.delay(v24, ScreenGui.Destroy, ScreenGui);

    if not p23._desynchronize then
        Util.synchronize();
    end;

    return ScreenGui;
end;

return v1;