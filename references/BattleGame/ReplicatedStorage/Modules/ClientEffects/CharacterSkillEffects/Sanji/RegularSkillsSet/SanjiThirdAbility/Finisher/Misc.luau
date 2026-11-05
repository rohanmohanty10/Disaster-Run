-- ManyMisc (TRIMMED)
-- Stripped down to only the parts that (a) your Sanji finisher uses and
-- (b) don't require modules your game is missing.
--
-- REMOVED (all depended on modules you don't have):
--   PartCache, Debris module, EasyEmitter (Emitter), Data.* (all of them),
--   VFXCache, ExtraVisual (ExtraVisualEffects), MotorHandler, PartStorage,
--   PhysicsPartStorage, AtmosphereHandler, Spring, RaycastHitbox, the RockLee
--   VisualPacks/animations, and every function built on top of those
--   (RockleeGetGateData, addAwakeningEnergy, stopAllAnims, removeAllBodyMovers,
--    delayState, GetLocalRootCFrame, etc.)
--
-- NOTE: This does NOT provide Misc.ExtraVisual (blur/FoV) or Misc.EasyEmitter —
-- those live in separate modules you don't have. Your skill should use the
-- native NoMisc version for those.
--
-- Keep the `SpecialMath` ModuleScript parented under this one.

local Misc = {}

-- Math helpers (rollOffValue + lerp are what the finisher uses).
Misc.SpecialMath = require(script:WaitForChild("SpecialMath"))

-- True if an instance is destroyed / no longer in the data model.
function Misc.Destroyed(inst, ignoreParent)
	if inst == nil or typeof(inst) ~= "Instance" then
		return true
	end
	if not ignoreParent and inst:IsDescendantOf(game) then
		return false
	end
	local _, err = pcall(function()
		inst.Parent = inst
	end)
	return err and (err:match("locked") and not err:match("as its own parent")) and true or false
end

-- Null-safe destroy for a single instance or a table of them.
function Misc:Destroy(target)
	if typeof(target) == "table" then
		for _, v in target do
			if not Misc.Destroyed(v, true) then
				v:Destroy()
			end
		end
	elseif not Misc.Destroyed(target, true) then
		target:Destroy()
	end
	return true
end

return Misc