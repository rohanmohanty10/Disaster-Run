  

 

local ViewportFrame = script.Parent.ViewportFrame;
ViewportFrame.Size = UDim2.new(1, 0, 1, 0);
ViewportFrame.BackgroundColor3 = Color3.new();
ViewportFrame.BackgroundTransparency = 0;
local v1 = game.ReplicatedStorage["Client Assets"].Goku.Shenron:Clone();
local HumanoidRootPart = v1.HumanoidRootPart;
v1.Parent = ViewportFrame.WorldModel;
local Animation = Instance.new("Animation");
Animation.AnimationId = "rbxassetid://7307505306";
v1.AnimationController:LoadAnimation(Animation):Play();
local Camera = Instance.new("Camera");
ViewportFrame.CurrentCamera = Camera;
Camera.Parent = ViewportFrame;
local _, v2 = v1:GetBoundingBox();
local v3 = HumanoidRootPart.CFrame * CFrame.new(0, 0, -(v2.Z / 2 + 15));
Camera.CFrame = CFrame.new(v3.Position, HumanoidRootPart.Position);