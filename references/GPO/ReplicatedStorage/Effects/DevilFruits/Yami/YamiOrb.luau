-- 

--local v1 = {}
--local u2 = {
--    0.5,
--    Enum.EasingStyle.Sine,
--    Enum.EasingDirection.Out,
--    0,
--    false,
--    0
--}
--local _ = {
--    1,
--    Enum.EasingStyle.Sine,
--    Enum.EasingDirection.Out,
--    0,
--    false,
--    0
--}
--local _ = {
--    1,
--    Enum.EasingStyle.Linear,
--    Enum.EasingDirection.Out,
--    0,
--    false,
--    0
--}
--local u3 = {
--    50,
--    Enum.EasingStyle.Quart,
--    Enum.EasingDirection.Out,
--    0,
--    true,
--    0
--}
--local u4 = {
--    0.25,
--    Enum.EasingStyle.Sine,
--    Enum.EasingDirection.Out,
--    0,
--    false,
--    0
--}
--local u5 = {
--    0.2,
--    Enum.EasingStyle.Sine,
--    Enum.EasingDirection.Out,
--    0,
--    true,
--    0
--}
--function v1.start(_, p6, p7, p8, p9) --[[ Line: 10 ]]
--    --[[
--    Upvalues:
--        [1] = u5
--        [2] = u4
--        [3] = u2
--        [4] = u3
--    --]]
--    if p6 == "hit" then
--        if (workspace.CurrentCamera.CFrame.Position - p7.Position).Magnitude < 200 then
--            local u10 = Instance.new("ColorCorrectionEffect")
--            u10.Parent = workspace.CurrentCamera
--            local u11 = Instance.new("BlurEffect")
--            u11.Parent = workspace.CurrentCamera
--            u11.Name = "BLURFX"
--            u11.Size = 0
--            coroutine.wrap(function() --[[ Line: 25 ]]
--                --[[
--                Upvalues:
--                    [1] = u10
--                    [2] = u11
--                    [3] = u5
--                    [4] = u4
--                --]]
--                u10.Brightness = -0.2
--                u10.Contrast = -2
--                u10.Saturation = -1
--                _G.tween(u11, u5, {
--                    ["Size"] = 15
--                })
--                task.wait(u5[1])
--                _G.tween(u10, u4, {
--                    ["Brightness"] = -0.1,
--                    ["Contrast"] = 0.2,
--                    ["Saturation"] = -0.8
--                })
--                _G.destroy(u11, 3)
--            end)()
--            task.wait(0.75)
--            _G.tween(u10, u5, {
--                ["Brightness"] = -0.1,
--                ["Contrast"] = 1.3,
--                ["Saturation"] = -1
--            })
--            task.wait(1)
--            _G.tween(u10, u4, {
--                ["Brightness"] = 0,
--                ["Contrast"] = 0,
--                ["Saturation"] = 0
--            })
--            _G.destroy(u10, 2)
--        end
--    else
--        if p6 == "charge" then
--            if _G.checkRenderDistance(p8.Position, 600) == false then
--                return
--            end
--            while p7.Name ~= "done" and (p7 and (not p7 or p7.Name ~= "done")) do
--                task.wait()
--                for _ = 1, 12 do
--                    local v12 = Instance.new("Attachment")
--                    local v13 = Instance.new("Attachment")
--                    v12.Parent = p8
--                    v13.Parent = p8
--                    local v14 = p8.Folder.Trail:Clone()
--                    v14.Parent = p8.Folder
--                    v14.Attachment0 = v12
--                    v14.Attachment1 = v13
--                    v14.Name = "TrailDupe"
--                    local v15 = math.random(-(p8.Size.X / (p8.Size.X / 45)), p8.Size.X / (p8.Size.X / 45))
--                    local v16 = math.random(-(p8.Size.Y / (p8.Size.Y / 45)), p8.Size.Y / (p8.Size.Y / 45))
--                    local v17 = math.random
--                    local v18 = -(p8.Size.Z / (p8.Size.Z / 45))
--                    local v19 = p8.Size.Z / (p8.Size.Z / 45)
--                    v12.Position = Vector3.new(v15, v16, v17(v18, v19))
--                    local v20 = v12.Position
--                    local v21 = math.random(-8, 8)
--                    local v22 = math.random(-8, 8)
--                    local v23 = math.random
--                    v13.Position = v20 + Vector3.new(v21, v22, v23(-8, 8))
--                    _G.tween(v12, u2, {
--                        ["Position"] = Vector3.new(0, 0, 0)
--                    })
--                    _G.tween(v13, u2, {
--                        ["Position"] = Vector3.new(0, 0, 0)
--                    })
--                    _G.tween(p8, u3, {
--                        ["Orientation"] = Vector3.new(0, 6000, 0)
--                    })
--                    _G.destroy(v12, 0.9)
--                    _G.destroy(v13, 0.9)
--                    _G.destroy(v14, 0.9)
--                    local v24 = Instance.new("Attachment")
--                    local v25 = math.random(-360, 360)
--                    local v26 = math.random(-360, 360)
--                    local v27 = math.random
--                    v24.Orientation = Vector3.new(v25, v26, v27(-360, 360))
--                    v24.Parent = p9.PrimaryPart
--                    local v28 = Instance.new("Attachment")
--                    local v29 = math.random(-360, 360)
--                    local v30 = math.random(-360, 360)
--                    local v31 = math.random
--                    v28.Orientation = Vector3.new(v29, v30, v31(-360, 360))
--                    local v32 = math.random(-15, 15)
--                    local v33 = math.random(12, 30)
--                    local v34 = math.random
--                    v28.Position = Vector3.new(v32, v33, v34(-15, 15))
--                    v28.Parent = p9.PrimaryPart
--                    local v35 = script.beam:Clone()
--                    v35.Parent = p9.PrimaryPart
--                    v35.Attachment0 = v24
--                    v35.Attachment1 = v28
--                    v35.CurveSize0 = math.random(5, 15)
--                    if math.random(1, 2) == 1 then
--                        v35.CurveSize0 = -v35.CurveSize0
--                    end
--                    v35.CurveSize1 = v35.CurveSize0 * -2
--                    v35.Width0 = math.random(10, 20)
--                    _G.tween(v35, {
--                        0.75,
--                        "Quad",
--                        Enum.EasingDirection.Out,
--                        0,
--                        false,
--                        0
--                    }, {
--                        ["CurveSize0"] = v35.CurveSize0 * -2,
--                        ["CurveSize1"] = v35.CurveSize1 * 2,
--                        ["Width0"] = 0
--                    })
--                    _G.tween(v24, {
--                        1,
--                        "Sine",
--                        Enum.EasingDirection.Out,
--                        0,
--                        false,
--                        0
--                    }, {
--                        ["Position"] = Vector3.new()
--                    })
--                    _G.destroy({ v24, v28, v35 }, 1)
--                end
--                task.wait(0.1)
--            end
--        end
--        return
--    end
--end
--return v1


local module = {}

-- Tween presets
local TWEEN_BLUR_IN = {
	0.2,
	Enum.EasingStyle.Sine,
	Enum.EasingDirection.Out,
	0,
	true,
	0
}

local TWEEN_CORRECTION_OUT = {
	0.25,
	Enum.EasingStyle.Sine,
	Enum.EasingDirection.Out,
	0,
	false,
	0
}

local TWEEN_TRAIL_CONVERGE = {
	0.5,
	Enum.EasingStyle.Sine,
	Enum.EasingDirection.Out,
	0,
	false,
	0
}

local TWEEN_SPIN = {
	50,
	Enum.EasingStyle.Quart,
	Enum.EasingDirection.Out,
	0,
	true,
	0
}

local TWEEN_BEAM_FADE = {
	0.75,
	"Quad",
	Enum.EasingDirection.Out,
	0,
	false,
	0
}

local TWEEN_BEAM_CONVERGE = {
	1,
	"Sine",
	Enum.EasingDirection.Out,
	0,
	false,
	0
}

-- ============================================================
-- Hit effect: screen color correction + blur when near impact
-- ============================================================
local function onHit(hitPosition)
	if (workspace.CurrentCamera.CFrame.Position - hitPosition).Magnitude >= 200 then
		return
	end

	local colorCorrection = Instance.new("ColorCorrectionEffect")
	colorCorrection.Parent = workspace.CurrentCamera

	local blur = Instance.new("BlurEffect")
	blur.Name = "BLURFX"
	blur.Size = 0
	blur.Parent = workspace.CurrentCamera

	-- Immediately slam brightness/contrast/saturation and blur in
	coroutine.wrap(function()
		colorCorrection.Brightness = -0.2
		colorCorrection.Contrast = -2
		colorCorrection.Saturation = -1

		_G.tween(blur, TWEEN_BLUR_IN, { Size = 15 })
		task.wait(TWEEN_BLUR_IN[1])

		_G.tween(colorCorrection, TWEEN_CORRECTION_OUT, {
			Brightness = -0.1,
			Contrast = 0.2,
			Saturation = -0.8,
		})

		_G.destroy(blur, 3)
	end)()

	-- After a short delay, ease color correction back toward normal
	task.wait(0.75)
	_G.tween(colorCorrection, TWEEN_BLUR_IN, {
		Brightness = -0.1,
		Contrast = 1.3,
		Saturation = -1,
	})

	task.wait(1)
	_G.tween(colorCorrection, TWEEN_CORRECTION_OUT, {
		Brightness = 0,
		Contrast = 0,
		Saturation = 0,
	})

	_G.destroy(colorCorrection, 2)
end

-- ============================================================
-- Charge effect: spinning trails + lightning beams while active
-- ============================================================
local function onCharge(stopSignal, chargePart, attackerModel)
	if not _G.checkRenderDistance(chargePart.Position, 600) then
		return
	end

	-- Loop until the stop signal is renamed to "done"
	while stopSignal.Name ~= "done" do
		task.wait()

		for _ = 1, 12 do
			-- Trail particles: two attachments that converge to center
			local trailAttach0 = Instance.new("Attachment")
			local trailAttach1 = Instance.new("Attachment")
			trailAttach0.Parent = chargePart
			trailAttach1.Parent = chargePart

			local trail = chargePart.Folder.Trail:Clone()
			trail.Name = "TrailDupe"
			trail.Attachment0 = trailAttach0
			trail.Attachment1 = trailAttach1
			trail.Parent = chargePart.Folder

			-- Scatter the attachments randomly within the part bounds then tween to center
			local halfX = chargePart.Size.X / 2
			local halfY = chargePart.Size.Y / 2
			local halfZ = chargePart.Size.Z / 2
			-- Note: original code computed -(size/(size/45)) which simplifies to just -45/+45
			local spawnRange = 45
			trailAttach0.Position = Vector3.new(
				math.random(-spawnRange, spawnRange),
				math.random(-spawnRange, spawnRange),
				math.random(-spawnRange, spawnRange)
			)
			trailAttach1.Position = trailAttach0.Position + Vector3.new(
				math.random(-8, 8),
				math.random(-8, 8),
				math.random(-8, 8)
			)

			_G.tween(trailAttach0, TWEEN_TRAIL_CONVERGE, { Position = Vector3.new(0, 0, 0) })
			_G.tween(trailAttach1, TWEEN_TRAIL_CONVERGE, { Position = Vector3.new(0, 0, 0) })
			_G.tween(chargePart, TWEEN_SPIN, { Orientation = Vector3.new(0, 6000, 0) })

			_G.destroy(trailAttach0, 0.9)
			_G.destroy(trailAttach1, 0.9)
			_G.destroy(trail, 0.9)

			-- Lightning beam: two randomly oriented attachments connected by a beam
			local beamAttach0 = Instance.new("Attachment")
			beamAttach0.Orientation = Vector3.new(
				math.random(-360, 360),
				math.random(-360, 360),
				math.random(-360, 360)
			)
			beamAttach0.Parent = attackerModel.PrimaryPart

			local beamAttach1 = Instance.new("Attachment")
			beamAttach1.Orientation = Vector3.new(
				math.random(-360, 360),
				math.random(-360, 360),
				math.random(-360, 360)
			)
			beamAttach1.Position = Vector3.new(
				math.random(-15, 15),
				math.random(12, 30),
				math.random(-15, 15)
			)
			beamAttach1.Parent = attackerModel.PrimaryPart

			local beam = script.beam:Clone()
			beam.Attachment0 = beamAttach0
			beam.Attachment1 = beamAttach1
			beam.CurveSize0 = math.random(5, 15)
			if math.random(1, 2) == 1 then
				beam.CurveSize0 = -beam.CurveSize0
			end
			beam.CurveSize1 = beam.CurveSize0 * -2
			beam.Width0 = math.random(10, 20)
			beam.Parent = attackerModel.PrimaryPart

			-- Animate beam curving and fading out
			_G.tween(beam, TWEEN_BEAM_FADE, {
				CurveSize0 = beam.CurveSize0 * -2,
				CurveSize1 = beam.CurveSize1 * 2,
				Width0 = 0,
			})
			_G.tween(beamAttach0, TWEEN_BEAM_CONVERGE, {
				Position = Vector3.new(0, 0, 0),
			})

			_G.destroy({ beamAttach0, beamAttach1, beam }, 1)
		end

		task.wait(0.1)
	end
end

-- ============================================================
-- Entry point
-- ============================================================
function module.start(_, eventType, arg1, arg2, arg3)
	if eventType == "hit" then
		-- arg1 = hit position (Vector3)
		onHit(arg1)

	elseif eventType == "charge" then
		-- arg1 = stop signal (Instance renamed to "done" to stop loop)
		-- arg2 = charge part (the spinning orb/part)
		-- arg3 = attacker model (for beam attachment)
		onCharge(arg1, arg2, arg3)
	end
end

return module