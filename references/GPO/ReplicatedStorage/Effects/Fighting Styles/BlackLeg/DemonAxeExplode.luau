local Effects = {}

local ORANGE = Color3.fromRGB(255, 81, 0)

function Effects.start(_, position, direction, groundPart)
	if _G.checkRenderDistance(position) == false then return end

	-- Ground rocks burst upward
	_G.PlayEffect("GroundRocks", nil, CFrame.new(position + Vector3.new(0, 5, 0)), 25, 6, 20, 5)

	-- Pillar mesh that stretches upward then disappears
	local pillar = script.Part:Clone()
	pillar.CFrame = CFrame.new(position)
	pillar.Mesh.Scale = Vector3.new(25, 45, 25)
	pillar.Parent = workspace.Effects

	_G.tween(pillar.Mesh,
		{ 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0 },
		{ Scale = Vector3.new(0, pillar.Mesh.Scale.Y + 15, 0), Offset = Vector3.new(0, 22.5, 0) }
	)
	_G.destroy(pillar, 0.15)
	_G.PlaySound(pillar, script.explode)

	-- Expanding ForceField sphere that fades out
	local sphere = script.Part:Clone()
	sphere.CFrame = CFrame.new(position)
	sphere.Material = Enum.Material.ForceField
	sphere.Transparency = -5
	sphere.Mesh.Scale = Vector3.new(18.75, 18.75, 18.75)
	sphere.Parent = workspace.Effects

	_G.tween(sphere.Mesh,
		{ 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0 },
		{ Scale = Vector3.new(75, 75, 75) }
	)
	_G.tween(sphere,
		{ 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0 },
		{ Transparency = 1 }
	)
	_G.destroy(sphere, 0.25)

	-- Dust/smoke particle effect oriented toward direction
	local dustCFrame = CFrame.new(position, position + direction) * CFrame.Angles(-math.pi / 2, 0, 0)
	local dust = script.dust:Clone()
	dust.CFrame = dustCFrame
	dust.Attachment.Rocks.Color = ColorSequence.new(groundPart.Color)
	dust.Attachment.sm2.Color = ColorSequence.new(groundPart.Color)
	dust.Attachment.BurningPart.Size = NumberSequence.new({
		NumberSequenceKeypoint.new(0,   5,  5),
		NumberSequenceKeypoint.new(0.5, 20, 5),
		NumberSequenceKeypoint.new(1,   0,  0),
	})
	dust.Parent = workspace.Effects
	_G.customEmit(dust)

	-- Shockwave ring
	_G.PlayEffect("Shockwave2", nil,
		dustCFrame, dustCFrame,
		BrickColor.new("White"),
		Vector3.new(100, 4, 100), Vector3.new(30, 4, 30),
		0.5, -1, Enum.EasingStyle.Quad,
		Color3.fromRGB(255, 255, 255), Enum.Material.Neon, "Rings"
	)
	_G.destroy(dust, 3)

	-- Phoenix slash effect with random orange color chance
	local slashColor = script.Part.Color
	if math.random(1, 2) == 1 then
		slashColor = ORANGE
	end

	_G.PlayEffect("PhoenixSlash", nil, 8, {
		CFrame             = dustCFrame,
		Scale              = 50,
		Offset             = CFrame.new(0, 5, 0),
		Color              = slashColor,
		Transparency       = -1,
		Duration           = 0.5,
		RotationDirection  = 3,
	})

	-- 8 fanning shards arranged in a circle around the impact point
	for i = 1, 8 do
		local angle     = math.rad(i * 45)
		local shardCF   = dustCFrame * CFrame.Angles(0, angle, 0) * CFrame.new(0, -2, 22.5)
		local facingCF  = CFrame.new(shardCF.Position, dustCFrame.Position) * CFrame.Angles(0, math.pi / 2, 0)

		-- Animated shard blade
		local shard = script.fart:Clone()
		shard.CFrame           = facingCF
		shard.Color            = groundPart.Color
		shard.Mesh.Offset      = Vector3.new(0, 0, 0)
		shard.Mesh.Scale       = Vector3.new(0, 0, 0)
		shard.Parent           = workspace.Effects

		_G.tween(shard.Mesh,
			{ 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, true, 0 },
			{ Scale = Vector3.new(45, 45, 45), Offset = Vector3.new(10, 0, 0) }
		)
		_G.tween(shard,
			{ 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0 },
			{ CFrame = shard.CFrame * CFrame.Angles(0, 0, -math.pi / 2) }
		)
		_G.tween(shard,
			{ 1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0 },
			{ Transparency = 1 }
		)
		_G.destroy(shard, 5)

		-- Small flash sphere at each shard position
		local flash = script.Part:Clone()
		flash.CFrame      = facingCF
		flash.Mesh.Scale  = Vector3.new(17.5, 17.5, 17.5)
		flash.Parent      = workspace.Effects

		_G.tween(flash.Mesh,
			{ 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0 },
			{ Scale = Vector3.new(35, 35, 35) }
		)
		_G.tween(flash,
			{ 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0 },
			{ Transparency = 1, Color = ORANGE }
		)
		_G.destroy(flash, 0.25)
	end
end

return Effects