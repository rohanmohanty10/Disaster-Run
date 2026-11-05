local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")

local GlassShatter = {}

local function rng(min, max)
	return min + math.random() * (max - min)
end

local function slice(x, y, w, h, depth, minSize, out)
	if depth <= 0 or w < minSize or h < minSize then
		table.insert(out, { x = x, y = y, w = w, h = h })
		return
	end

	if w > h then
		local cut = w * rng(0.3, 0.7)
		slice(x, y, cut, h, depth - 1, minSize, out)
		slice(x + cut, y, w - cut, h, depth - 1, minSize, out)
	else
		local cut = h * rng(0.3, 0.7)
		slice(x, y, w, cut, depth - 1, minSize, out)
		slice(x, y + cut, w, h - cut, depth - 1, minSize, out)
	end
end

function GlassShatter.Play(opts)
	opts = opts or {}
	local cam = workspace.CurrentCamera
	if not cam then return end

	local depth = opts.Depth or 3
	local impact = opts.ImpactPosition or Vector2.new(0.5, 0.5)
	local shardColor = opts.Color or Color3.fromRGB(245, 245, 250)
	local dist = opts.Distance or 4
	local holdTime = opts.HoldTime or 0.01
	local gravity = opts.FallAcceleration or 150
	local thickness = opts.Thickness or 0.01

	local camCF = cam.CFrame
	local look, up, right = camCF.LookVector, camCF.UpVector, camCF.RightVector
	local view = cam.ViewportSize
	local halfH = dist * math.tan(math.rad(cam.FieldOfView * 0.5)) * 1.1
	local halfW = halfH * (view.X / view.Y)
	local planeW, planeH = halfW * 2, halfH * 2

	local minSize = math.min(planeW, planeH) / 8
	local hit = Vector2.new(planeW * impact.X, planeH * impact.Y)

	local pieces = {}
	slice(0, 0, planeW, planeH, depth, minSize, pieces)

	local folder = Instance.new("Folder")
	folder.Name = "shards"
	folder.Parent = workspace.World.Visuals

	local active = {}
	local maxLifetime = holdTime

	for i = 1, #pieces do
		local p = pieces[i]
		local center = Vector2.new(p.x + p.w * 0.5, p.y + p.h * 0.5)
		local localX, localY = center.X - planeW * 0.5, -(center.Y - planeH * 0.5)
		local worldPos = camCF.Position + look * dist + right * localX + up * localY
		local shardCF = CFrame.fromMatrix(worldPos, look, up, right)

		local w1 = Instance.new("WedgePart")
		w1.Size = Vector3.new(thickness, p.h, p.w)
		w1.CFrame = shardCF
		w1.Anchored, w1.CanCollide, w1.CanTouch = true, false, false
		w1.CanQuery, w1.CastShadow = false, false
		w1.Reflectance, w1.Transparency = 0, 0.8
		w1.Material, w1.Color = Enum.Material.Glass, shardColor
		w1.Parent = folder

		local w2 = w1:Clone()
		w2.CFrame = shardCF * CFrame.Angles(math.pi, 0, 0)
		w2.Parent = folder

		local dir = (center - hit).Magnitude > 0.1 and (center - hit).Unit or Vector2.new(rng(-1, 1), rng(-1, 1)).Unit
		local delayTime = holdTime + (center - hit).Magnitude / (math.max(planeW, planeH) * 1.4)

		for _, part in ipairs({ w1, w2 }) do
			local spd = rng(4, 9)
			local fade = rng(1.1, 1.6)
			local data = {
				part = part,
				vel = right * dir.X * spd - up * dir.Y * spd + look * rng(-1, 2),
				rot = Vector3.new(rng(-6, 6), rng(-6, 6), rng(-6, 6)),
				active = false
			}
			table.insert(active, data)
			maxLifetime = math.max(maxLifetime, delayTime + fade)

			task.delay(delayTime, function()
				if not part.Parent then return end
				data.active = true
				TweenService:Create(part, TweenInfo.new(fade, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Transparency = 1 }):Play()
				Debris:AddItem(part, fade + 0.1)
			end)
		end
	end

	local conn
	conn = RunService.Heartbeat:Connect(function(dt)
		for i = 1, #active do
			local item = active[i]
			if item.active and item.part.Parent then
				item.vel += Vector3.new(0, -gravity * dt, 0)
				item.part.CFrame = (item.part.CFrame + item.vel * dt) * CFrame.Angles(item.rot.X * dt, item.rot.Y * dt, item.rot.Z * dt)
			end
		end
	end)

	task.delay(maxLifetime + 0.3, function()
		conn:Disconnect()
	end)

	Debris:AddItem(folder, maxLifetime + 0.5)
end

return GlassShatter