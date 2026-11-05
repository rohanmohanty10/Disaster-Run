  

 

local u1 = {
    Players = game:GetService("Players"),
    RunService = game:GetService("RunService"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    TweenService = game:GetService("TweenService")
};
local _ = u1.Players.LocalPlayer;
local Parent = script.Parent;
local Value = Parent:WaitForChild("User").Value;
local u2 = "Rainbow_Character_" .. Value.Name;
local v3 = {
    [Enum.BodyPart.LeftArm] = "Left Arm",
    [Enum.BodyPart.RightArm] = "Right Arm",
    [Enum.BodyPart.LeftLeg] = "Left Leg",
    [Enum.BodyPart.RightLeg] = "Right Leg",
    [Enum.BodyPart.Torso] = "Torso",
    [Enum.BodyPart.Head] = "Head"
};
local ViewportFrame = Parent:WaitForChild("ViewportFrame");
local Camera = Instance.new("Camera");
Camera.Parent = ViewportFrame;
ViewportFrame.CurrentCamera = Camera;
local R6 = ViewportFrame.WorldModel.R6;
local u4 = {};
local u5 = false;

for _, child in Value:GetChildren() do
    if child:IsA("Accessory") or child:IsA("CharacterMesh") then
        if child:IsA("Accessory") then
            local v6 = child:FindFirstChild("Handle") or child:FindFirstChildWhichIsA("BasePart");

            if v6 then
                v6 = v6:FindFirstChild("Weld") or v6:FindFirstChildOfClass("Weld");
            end;

            if v6 then
                local v7 = child:Clone();
                local v8 = v7:FindFirstChild("Handle") or v7:FindFirstChildWhichIsA("BasePart");
                local v9;

                if v8 and not (v8:IsA("MeshPart") and v8) then
                    v9 = v8:FindFirstChildOfClass("SpecialMesh");
                else
                    v9 = v8;
                end;

                if v8 then
                    v8 = v8:FindFirstChild("Weld") or v8:FindFirstChildOfClass("Weld");
                end;

                v8.Enabled = false;
                v7.Parent = R6;
                v8.Part1 = R6[v6.Part1.Name];
                v8.Enabled = true;

                if v9 then
                    v9["Texture" .. (v9:IsA("MeshPart") and "ID" or "Id")] = "rbxassetid://13803932886";
                end;
            end;
        else
            Instance.fromExisting(child).Parent = R6;
            local Limb = R6[v3[child.BodyPart]]:FindFirstChild("Limb");

            if Limb then
                Limb.Mesh.MeshId = "rbxassetid://" .. child.MeshId;
            end;
        end;
    elseif child:IsA("BasePart") and R6:FindFirstChild(child.Name) then
        if child.Name == "Head" then
            local v10 = child:FindFirstChild("Mesh") or child:FindFirstChildOfClass("SpecialMesh");

            if v10 then
                R6.Head.Mesh.MeshId = v10.MeshId;
                R6.Head.Mesh.TextureId = v10.TextureId;
                R6.Head.Mesh.MeshType = v10.MeshType;
                R6.Head.Mesh.Scale = v10.Scale;
            end;

            local v11 = child:FindFirstChild("face") or child:FindFirstChildOfClass("Decal");

            if v11 then
                R6.Head.face.Texture = v11.Texture;
                R6.Head.face.Transparency = 1;
            end;
        end;

        u4[R6[child.Name]] = child;
        R6[child.Name].Color = Color3.new(1, 1, 1);
        R6[child.Name].Material = Enum.Material.Neon;
    end;
end;

local function CreateRainbowSequence(p12, p13, p14, p15) -- Line: 95
    local v16 = {};

    for i = 1, p12 do
        local v17 = (i - 1) / (p12 - 1);
        table.insert(v16, ColorSequenceKeypoint.new(v17, Color3.fromHSV((v17 - p13) % 1, p14 or 1, p15 or 1)));
    end;

    return ColorSequence.new(v16);
end;

local u19 = u1.RunService.Heartbeat:Connect(function(p18) -- Line: 106
    -- upvalues: ViewportFrame (copy), CreateRainbowSequence (copy), Value (copy), u5 (ref), u1 (copy), u2 (copy), Camera (copy), u4 (copy)
    ViewportFrame.UIGradient.Color = CreateRainbowSequence(16, tick() * 1.25);
    local Magnitude = (Value.HumanoidRootPart.Position - workspace.CurrentCamera.CFrame.Position).Magnitude;

    if Magnitude <= 300 or not u5 then
        if Magnitude < 300 and not u5 then
            u5 = true;
            u1.RunService:BindToRenderStep(u2, Enum.RenderPriority.Camera.Value + 6, function() -- Line: 116
                -- upvalues: u4 (ref), Camera (ref)
                for i, v in u4 do
                    i.CFrame = v and v.CFrame or CFrame.identity;
                end;

                Camera.CFrame = workspace.CurrentCamera.CFrame;
                Camera.FieldOfView = workspace.CurrentCamera.FieldOfView;
            end);
        end;

        return;
    end;

    u5 = false;
    u1.RunService:UnbindFromRenderStep(u2);
    Camera.CFrame = CFrame.new(0, 1000, 0);
end);
Parent:GetAttributeChangedSignal("Stop"):Once(function() -- Line: 130
    -- upvalues: Parent (copy), u1 (copy), ViewportFrame (copy), u19 (copy), u2 (copy)
    local v20 = Parent:GetAttribute("Stop");

    if typeof(v20) == "number" then
        local v21 = u1.TweenService:Create(ViewportFrame, TweenInfo.new(v20, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        });
        v21:Play();
        v21.Completed:Wait();
    end;

    ViewportFrame.Visible = false;
    u19:Disconnect();
    u1.RunService:UnbindFromRenderStep(u2);
end);