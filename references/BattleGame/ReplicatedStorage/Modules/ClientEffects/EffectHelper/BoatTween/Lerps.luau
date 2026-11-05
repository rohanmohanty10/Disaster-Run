local ipairs_upvr = ipairs
local Color3_new_result1_upvr = Color3.new()

local function RobloxLerp(arg1, arg2)
	return function(arg1_2)
		return arg1:Lerp(arg2, arg1_2)
	end
end

local function Lerp(arg1, arg2, arg3)
	return arg1 + arg3 * (arg2 - arg1)
end

local function SortByTime_upvr(arg1, arg2)
	if arg1.Time >= arg2.Time then
		return false
	else
		return true
	end
end

local function Color3Lerp_upvr(arg1, arg2)
	local L0, U0, V0
	local R0, G0, B0 = arg1.R, arg1.G, arg1.B
	R0 = R0 < 0.0404482362771076 and R0 / 12.92 or 0.87941546140213 * (R0 + 0.055) ^ 2.4
	G0 = G0 < 0.0404482362771076 and G0 / 12.92 or 0.87941546140213 * (G0 + 0.055) ^ 2.4
	B0 = B0 < 0.0404482362771076 and B0 / 12.92 or 0.87941546140213 * (B0 + 0.055) ^ 2.4

	local Y0 = 0.2125862307855956 * R0 + 0.71517030370341085 * G0 + 0.0722004986433362 * B0
	local Z0 = 3.6590806972265883 * R0 + 11.4426895800574232 * G0 + 4.1149915024264843 * B0
	local _L0 = Y0 > 0.008856451679035631 and 116 * Y0 ^ (1 / 3) - 16 or 903.296296296296 * Y0

	if Z0 > 1E-15 then
		local X = 0.9257063972951867 * R0 - 0.8333736323779866 * G0 - 0.09209820666085898 * B0
		L0, U0, V0 = _L0, _L0 * X / Z0, _L0 * (9 * Y0 / Z0 - 0.46832)
	else
		L0, U0, V0 = _L0, -0.19783 * _L0, -0.46832 * _L0
	end

	local L1, U1, V1
	local R1, G1, B1 = arg2.R, arg2.G, arg2.B
	R1 = R1 < 0.0404482362771076 and R1 / 12.92 or 0.87941546140213 * (R1 + 0.055) ^ 2.4
	G1 = G1 < 0.0404482362771076 and G1 / 12.92 or 0.87941546140213 * (G1 + 0.055) ^ 2.4
	B1 = B1 < 0.0404482362771076 and B1 / 12.92 or 0.87941546140213 * (B1 + 0.055) ^ 2.4

	local Y1 = 0.2125862307855956 * R1 + 0.71517030370341085 * G1 + 0.0722004986433362 * B1
	local Z1 = 3.6590806972265883 * R1 + 11.4426895800574232 * G1 + 4.1149915024264843 * B1
	local _L1 = Y1 > 0.008856451679035631 and 116 * Y1 ^ (1 / 3) - 16 or 903.296296296296 * Y1

	if Z1 > 1E-15 then
		local X = 0.9257063972951867 * R1 - 0.8333736323779866 * G1 - 0.09209820666085898 * B1
		L1, U1, V1 = _L1, _L1 * X / Z1, _L1 * (9 * Y1 / Z1 - 0.46832)
	else
		L1, U1, V1 = _L1, -0.19783 * _L1, -0.46832 * _L1
	end

	return function(arg1_3)
		local L = (1 - arg1_3) * L0 + arg1_3 * L1
		if L < 0.0197955 then
			return Color3_new_result1_upvr
		end

		local U = ((1 - arg1_3) * U0 + arg1_3 * U1) / L + 0.19783
		local V = ((1 - arg1_3) * V0 + arg1_3 * V1) / L + 0.46832

		local Y = (L + 16) / 116
		Y = Y > 0.206896551724137931 and Y * Y * Y or 0.12841854934601665 * Y - 0.01771290335807126
		local X = Y * U / V
		local Z = Y * ((3 - 0.75 * U) / V - 5)

		local R = 7.2914074 * X - 1.5372080 * Y - 0.4986286 * Z
		local G = -2.1800940 * X + 1.8757561 * Y + 0.0415175 * Z
		local B = 0.1253477 * X - 0.2040211 * Y + 1.0569959 * Z

		if R < 0 and R < G and R < B then
			R, G, B = 0, G - R, B - R
		elseif G < 0 and G < B then
			R, G, B = R - G, 0, B - G
		elseif B < 0 then
			R, G, B = R - B, G - B, 0
		end

		R = R < 3.1306684425E-3 and 12.92 * R or 1.055 * R ^ (1 / 2.4) - 0.055
		G = G < 3.1306684425E-3 and 12.92 * G or 1.055 * G ^ (1 / 2.4) - 0.055
		B = B < 3.1306684425E-3 and 12.92 * B or 1.055 * B ^ (1 / 2.4) - 0.055

		R = R > 1 and 1 or R < 0 and 0 or R
		G = G > 1 and 1 or G < 0 and 0 or G
		B = B > 1 and 1 or B < 0 and 0 or B

		return Color3.new(R, G, B)
	end
end

local module = {
	boolean = function(arg1, arg2)
		return function(arg1_4)
			if arg1_4 < 0.5 then
				return arg1
			end
			return arg2
		end
	end;

	number = function(arg1, arg2)
		local var40_upvr = arg2 - arg1
		return function(arg1_5)
			return arg1 + var40_upvr * arg1_5
		end
	end;

	string = function(V0, V1)
		local RegularString = false

		local N0, D do
			local Sign0, H0, M0, S0 = string.match(V0, "^([+-]?)(%d*):[+-]?(%d*):[+-]?(%d*)$")
			local Sign1, H1, M1, S1 = string.match(V1, "^([+-]?)(%d*):[+-]?(%d*):[+-]?(%d*)$")
			if Sign0 and Sign1 then
				N0 = 3600 * (tonumber(H0) or 0) + 60 * (tonumber(M0) or 0) + (tonumber(S0) or 0)
				local N1 = 3600 * (tonumber(H1) or 0) + 60 * (tonumber(M1) or 0) + (tonumber(S1) or 0)
				if Sign0 == "-" then
					N0 = -N0
				end

				D = (43200 + (Sign1 ~= "-" and N1 or -N1) - N0) % 86400 - 43200
			else
				RegularString = true
			end
		end

		if RegularString then
			local Length = #V1
			return function(Alpha)
				Alpha = 1 + Length * Alpha
				return string.sub(V1, 1, Alpha < Length and Alpha or Length)
			end
		else
			return function(Alpha)
				local FS = (N0 + D * Alpha) % 86400
				local S = math.abs(FS)
				return string.format(
					FS < 0 and "-%.2u:%.2u:%.2u" or "%.2u:%.2u:%.2u",
					(S - S % 3600) / 3600,
					(S % 3600 - S % 60) / 60,
					S % 60
				)
			end
		end
	end;

	CFrame = RobloxLerp;
	Color3 = Color3Lerp_upvr;

	NumberRange = function(arg1, arg2)
		local Min_upvr = arg1.Min
		local Max_upvr = arg1.Max
		local var44_upvr = arg2.Min - Min_upvr
		local var45_upvr = arg2.Max - Max_upvr
		return function(arg1_6)
			return NumberRange.new(Min_upvr + arg1_6 * var44_upvr, Max_upvr + arg1_6 * var45_upvr)
		end
	end;

	NumberSequenceKeypoint = function(arg1, arg2)
		local Time_upvr = arg1.Time
		local Value_upvr = arg1.Value
		local Envelope_upvr = arg1.Envelope
		local var50_upvr = arg2.Time - Time_upvr
		local var51_upvr = arg2.Value - Value_upvr
		local var52_upvr = arg2.Envelope - Envelope_upvr
		return function(arg1_7)
			return NumberSequenceKeypoint.new(Time_upvr + arg1_7 * var50_upvr, Value_upvr + arg1_7 * var51_upvr, Envelope_upvr + arg1_7 * var52_upvr)
		end
	end;

	PhysicalProperties = function(arg1, arg2)
		local Density_upvr = arg1.Density
		local Elasticity_upvr = arg1.Elasticity
		local ElasticityWeight_upvr = arg1.ElasticityWeight
		local Friction_upvr = arg1.Friction
		local FrictionWeight_upvr = arg1.FrictionWeight
		local var59_upvr = arg2.Density - Density_upvr
		local var60_upvr = arg2.Elasticity - Elasticity_upvr
		local var61_upvr = arg2.ElasticityWeight - ElasticityWeight_upvr
		local var62_upvr = arg2.Friction - Friction_upvr
		local var63_upvr = arg2.FrictionWeight - FrictionWeight_upvr
		return function(arg1_8)
			return PhysicalProperties.new(
				Density_upvr + arg1_8 * var59_upvr,
				Elasticity_upvr + arg1_8 * var60_upvr,
				ElasticityWeight_upvr + arg1_8 * var61_upvr,
				Friction_upvr + arg1_8 * var62_upvr,
				FrictionWeight_upvr + arg1_8 * var63_upvr
			)
		end
	end;

	Ray = function(arg1, arg2)
		local Origin = arg1.Origin
		local Direction = arg1.Direction
		local Origin_2 = arg2.Origin
		local Direction_2 = arg2.Direction
		local X_4_upvr = Origin.X
		local Y_3_upvr = Origin.Y
		local Z_upvr_2 = Origin.Z
		local X_3_upvr = Direction.X
		local Y_4_upvr = Direction.Y
		local Z_upvr = Direction.Z
		local var75_upvr = Origin_2.X - X_4_upvr
		local var76_upvr = Origin_2.Y - Y_3_upvr
		local var77_upvr = Origin_2.Z - Z_upvr_2
		local var78_upvr = Direction_2.X - X_3_upvr
		local var79_upvr = Direction_2.Y - Y_4_upvr
		local var80_upvr = Direction_2.Z - Z_upvr
		return function(arg1_9)
			return Ray.new(
				Vector3.new(X_4_upvr + arg1_9 * var75_upvr, Y_3_upvr + arg1_9 * var76_upvr, Z_upvr_2 + arg1_9 * var77_upvr),
				Vector3.new(X_3_upvr + arg1_9 * var78_upvr, Y_4_upvr + arg1_9 * var79_upvr, Z_upvr + arg1_9 * var80_upvr)
			)
		end
	end;

	UDim = function(arg1, arg2)
		local Scale_upvr = arg1.Scale
		local Offset_upvr = arg1.Offset
		local var84_upvr = arg2.Scale - Scale_upvr
		local var85_upvr = arg2.Offset - Offset_upvr
		return function(arg1_10)
			return UDim.new(Scale_upvr + arg1_10 * var84_upvr, Offset_upvr + arg1_10 * var85_upvr)
		end
	end;

	UDim2 = RobloxLerp;
	Vector2 = RobloxLerp;
	Vector3 = RobloxLerp;

	Rect = function(arg1, arg2)
		return function(arg1_11)
			return Rect.new(
				arg1.Min.X + arg1_11 * (arg2.Min.X - arg1.Min.X),
				arg1.Min.Y + arg1_11 * (arg2.Min.Y - arg1.Min.Y),
				arg1.Max.X + arg1_11 * (arg2.Max.X - arg1.Max.X),
				arg1.Max.Y + arg1_11 * (arg2.Max.Y - arg1.Max.Y)
			)
		end
	end;

	Region3 = function(arg1, arg2)
		return function(arg1_12)
			local imin = Lerp(arg1.CFrame * (-arg1.Size / 2), arg2.CFrame * (-arg2.Size / 2), arg1_12)
			local imax = Lerp(arg1.CFrame * (arg1.Size / 2), arg2.CFrame * (arg2.Size / 2), arg1_12)

			local iminx = imin.X
			local imaxx = imax.X
			local iminy = imin.Y
			local imaxy = imax.Y
			local iminz = imin.Z
			local imaxz = imax.Z

			return Region3.new(
				Vector3.new(
					iminx < imaxx and iminx or imaxx,
					iminy < imaxy and iminy or imaxy,
					iminz < imaxz and iminz or imaxz
				),
				Vector3.new(
					iminx > imaxx and iminx or imaxx,
					iminy > imaxy and iminy or imaxy,
					iminz > imaxz and iminz or imaxz
				)
			)
		end
	end;

	NumberSequence = function(arg1, arg2)
		return function(arg1_13)
			local keypoints = {}
			local addedTimes = {}
			local keylength = 0

			for _, ap in ipairs_upvr(arg1.Keypoints) do
				local closestAbove, closestBelow

				for _, bp in ipairs_upvr(arg2.Keypoints) do
					if bp.Time == ap.Time then
						closestAbove, closestBelow = bp, bp
						break
					elseif bp.Time < ap.Time and (closestBelow == nil or bp.Time > closestBelow.Time) then
						closestBelow = bp
					elseif bp.Time > ap.Time and (closestAbove == nil or bp.Time < closestAbove.Time) then
						closestAbove = bp
					end
				end

				local bValue, bEnvelope
				if closestAbove == closestBelow then
					bValue, bEnvelope = closestAbove.Value, closestAbove.Envelope
				else
					local p = (ap.Time - closestBelow.Time) / (closestAbove.Time - closestBelow.Time)
					bValue = (closestAbove.Value - closestBelow.Value) * p + closestBelow.Value
					bEnvelope = (closestAbove.Envelope - closestBelow.Envelope) * p + closestBelow.Envelope
				end

				keylength += 1
				keypoints[keylength] = NumberSequenceKeypoint.new(
					ap.Time,
					(bValue - ap.Value) * arg1_13 + ap.Value,
					(bEnvelope - ap.Envelope) * arg1_13 + ap.Envelope
				)
				addedTimes[ap.Time] = true
			end

			for _, bp in ipairs_upvr(arg2.Keypoints) do
				if not addedTimes[bp.Time] then
					local closestAbove, closestBelow

					for _, ap in ipairs_upvr(arg1.Keypoints) do
						if ap.Time == bp.Time then
							closestAbove, closestBelow = ap, ap
							break
						elseif ap.Time < bp.Time and (closestBelow == nil or ap.Time > closestBelow.Time) then
							closestBelow = ap
						elseif ap.Time > bp.Time and (closestAbove == nil or ap.Time < closestAbove.Time) then
							closestAbove = ap
						end
					end

					local aValue, aEnvelope
					if closestAbove == closestBelow then
						aValue, aEnvelope = closestAbove.Value, closestAbove.Envelope
					else
						local p = (bp.Time - closestBelow.Time) / (closestAbove.Time - closestBelow.Time)
						aValue = (closestAbove.Value - closestBelow.Value) * p + closestBelow.Value
						aEnvelope = (closestAbove.Envelope - closestBelow.Envelope) * p + closestBelow.Envelope
					end

					keylength += 1
					keypoints[keylength] = NumberSequenceKeypoint.new(
						bp.Time,
						(bp.Value - aValue) * arg1_13 + aValue,
						(bp.Envelope - aEnvelope) * arg1_13 + aEnvelope
					)
				end
			end

			table.sort(keypoints, SortByTime_upvr)
			return NumberSequence.new(keypoints)
		end
	end;
}

function module.ColorSequence(arg1, arg2)
	return function(arg1_14)
		local keypoints = {}
		local addedTimes = {}
		local keylength = 0

		for _, ap in ipairs_upvr(arg1.Keypoints) do
			local closestAbove, closestBelow

			for _, bp in ipairs_upvr(arg2.Keypoints) do
				if bp.Time == ap.Time then
					closestAbove, closestBelow = bp, bp
					break
				elseif bp.Time < ap.Time and (closestBelow == nil or bp.Time > closestBelow.Time) then
					closestBelow = bp
				elseif bp.Time > ap.Time and (closestAbove == nil or bp.Time < closestAbove.Time) then
					closestAbove = bp
				end
			end

			local bValue
			if closestAbove == closestBelow then
				bValue = closestAbove.Value
			else
				bValue = Color3Lerp_upvr(closestBelow.Value, closestAbove.Value)(
					(ap.Time - closestBelow.Time) / (closestAbove.Time - closestBelow.Time)
				)
			end

			keylength += 1
			keypoints[keylength] = ColorSequenceKeypoint.new(ap.Time, Color3Lerp_upvr(ap.Value, bValue)(arg1_14))
			addedTimes[ap.Time] = true
		end

		for _, bp in ipairs_upvr(arg2.Keypoints) do
			if not addedTimes[bp.Time] then
				local closestAbove, closestBelow

				for _, ap in ipairs_upvr(arg1.Keypoints) do
					if ap.Time == bp.Time then
						closestAbove, closestBelow = ap, ap
						break
					elseif ap.Time < bp.Time and (closestBelow == nil or ap.Time > closestBelow.Time) then
						closestBelow = ap
					elseif ap.Time > bp.Time and (closestAbove == nil or ap.Time < closestAbove.Time) then
						closestAbove = ap
					end
				end

				local aValue
				if closestAbove == closestBelow then
					aValue = closestAbove.Value
				else
					aValue = Color3Lerp_upvr(closestBelow.Value, closestAbove.Value)(
						(bp.Time - closestBelow.Time) / (closestAbove.Time - closestBelow.Time)
					)
				end

				keylength += 1
				keypoints[keylength] = ColorSequenceKeypoint.new(bp.Time, Color3Lerp_upvr(bp.Value, aValue)(arg1_14))
			end
		end

		table.sort(keypoints, SortByTime_upvr)
		return ColorSequence.new(keypoints)
	end
end

return setmetatable(module, {
	__index = function(arg1, arg2)
		error("No lerp function is defined for type " .. tostring(arg2) .. ".", 4)
	end;
	__newindex = function(arg1, arg2)
		error("No lerp function is defined for type " .. tostring(arg2) .. ".", 4)
	end;
})