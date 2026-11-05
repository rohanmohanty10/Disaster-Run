--!strict
-- ReticleController — shows a ground marker where the divebomb will land,
-- following the camera aim and clamped to DiveAim.MAX_RANGE.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService        = game:GetService("RunService")
local Players           = game:GetService("Players")

local DiveAim = require(ReplicatedStorage.Modules.DiveAim)
-- local AimCam = require(ReplicatedStorage.Modules.Client.AimCam) -- optional zoom-in cam

local LocalPlayer = Players.LocalPlayer

-- Drop your reticle asset here (flat Part w/ decal, or Model w/ PrimaryPart). nil = fallback disc.
local RETICLE_TEMPLATE = script:FindFirstChild("Model") --ReplicatedStorage.Assets:FindFirstChild("DiveReticle")

local ReticleController = {}
local reticle = nil
local renderConn: RBXScriptConnection? = nil
local currentAimDir: Vector3 = Vector3.new(0, -1, 0)

--local function makeFallbackReticle(): BasePart
--	local p = Instance.new("Part")
--	p.Name, p.Shape = "DiveReticle", Enum.PartType.Cylinder
--	p.Size = Vector3.new(0.2, 12, 12)         -- thin along X => lies flat after the roll below
--	p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch, p.Massless = true, false, false, false, true
--	p.Material, p.Color, p.Transparency = Enum.Material.Neon, Color3.fromRGB(255, 80, 60), 0.35
--	return p
--end

local VFX = require(game.ReplicatedStorage.Modules.ClientEffects.G_VFX)
local Essentials = require(game.ReplicatedStorage.Modules.ClientEffects.G_Essentials)

local Emit        = VFX.Emit
local TweenCreate = Essentials.Tween     -- re-exported from Essentials
local Ess         = Essentials   

function ReticleController.Start(character: Model?)
	character = character or LocalPlayer.Character
	local hrp = character and character:FindFirstChild("HumanoidRootPart") :: BasePart?
	if not hrp then return end
	ReticleController.Stop()

	-- AimCam.Start(character, { fov = 50, tweenInfo = { duration = 0.5,
	--     easingStyle = Enum.EasingStyle.Sine, easingDirection = Enum.EasingDirection.InOut } })

	reticle = RETICLE_TEMPLATE:Clone() --or makeFallbackReticle()
	reticle.Parent = workspace.World.Visuals
	
	local primed = false
	renderConn = RunService.RenderStepped:Connect(function()
		local cam = workspace.CurrentCamera
		if not (reticle and reticle.Parent and hrp and hrp.Parent and cam) then
			ReticleController.Stop()
			return
		end

		local dir = cam.CFrame.LookVector
		currentAimDir = dir
		local point, normal = DiveAim.resolve(hrp.Position, dir, 150)

		-- Lay flat on the surface, oriented to the normal, spun to follow camera yaw.
		-- (Same math as your reference script.)
		local up = normal
		local dot = up:Dot(Vector3.new(0, 1, 0))
		local tangent = up:Cross(math.abs(dot) < 0.99 and Vector3.new(0,1,0) or Vector3.new(1,0,0)).Unit
		local bitangent = tangent:Cross(up).Unit
		local _, camYaw = cam.CFrame:ToOrientation()

		-- For single parts. We switch to a multi part system now,
		--reticle.CFrame = CFrame.fromMatrix(point + up * 0.1, tangent, up, bitangent)
		--	* CFrame.fromOrientation(0, camYaw, 0)
		--	* CFrame.Angles(0, 0, math.pi / 2)
		
		reticle:PivotTo(
			CFrame.fromMatrix(point + up * .1, tangent, up, bitangent)
				* CFrame.fromOrientation(0, camYaw, 0)
				* CFrame.Angles(math.rad(90), math.rad(0), math.rad(0))
		)
		--reticle:PivotTo(
		--	CFrame.fromMatrix(point + up * 0.1, tangent, up, bitangent)
		--		* CFrame.fromOrientation(0, camYaw, 0)
		--)
		if not primed then
			primed = true
			for _, d in reticle:GetDescendants() do
				if d:IsA("ParticleEmitter") then
					d:Emit(d:GetAttribute("EmitCount"))                           -- keep it showing the whole duration
					--d:Emit(math.ceil(d.Rate * d.Lifetime.Max)) -- instant fill, skips the ramp-up
				end
			end
		end

	end)
end

function ReticleController.Stop()
	if renderConn then renderConn:Disconnect(); renderConn = nil end
	if reticle then reticle:Destroy(); reticle = nil end
	-- AimCam.Stop()
end

-- The release input calls this and sends the result to the server.
function ReticleController.GetAimDirection(): Vector3
	return currentAimDir
end

return ReticleController