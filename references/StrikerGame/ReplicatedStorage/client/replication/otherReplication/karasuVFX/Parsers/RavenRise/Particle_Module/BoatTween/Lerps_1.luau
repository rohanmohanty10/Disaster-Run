 
-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=4939498795

-- ! Source from the asset above; the game may have edited it since.

--[[
local ipairs = ipairs
local BLACK_COLOR3 = Color3.new()

-- Generic Roblox DataType lerp function.
local function RobloxLerp(V0, V1)
	return function(Alpha)
		return V0:Lerp(V1, Alpha)
	end
end

local function Lerp(Start, Finish, Alpha)
	return Start + Alpha * (Finish - Start)
end

local function SortByTime(A, B)
	return A.Time < B.Time
end

local function Color3Lerp(C0, C1)
	local L0, U0, V0
	local R0, G0, B0 = C0.R, C0.G, C0.B
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
	local R1, G1, B1 = C1.R, C1.G, C1.B
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

	return function(Alpha)
		local L = (1 - Alpha) * L0 + Alpha * L1
		if L < 0.0197955 then
			return BLACK_COLOR3
		end

		local U = ((1 - Alpha) * U0 + Alpha * U1) / L + 0.19783
		local V = ((1 - Alpha) * V0 + Alpha * V1) / L + 0.46832

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

		R = R < 3.1306684425E-3 and 12.92 * R or 1.055 * R ^ (1 / 2.4) - 0.055 -- 3.1306684425E-3
		G = G < 3.1306684425E-3 and 12.92 * G or 1.055 * G ^ (1 / 2.4) - 0.055
		B = B < 3.1306684425E-3 and 12.92 * B or 1.055 * B ^ (1 / 2.4) - 0.055

		R = R > 1 and 1 or R < 0 and 0 or R
		G = G > 1 and 1 or G < 0 and 0 or G
		B = B > 1 and 1 or B < 0 and 0 or B

		return Color3.new(R, G, B)
	end
end

local Lerps = setmetatable({
	boolean = function(V0, V1)
		return function(Alpha)
			if Alpha < 0.5 then
				return V0
			else
				return V1
			end
		end
	end;

	number = function(V0, V1)
		local Delta = V1 - V0
		return function(Alpha)
			return V0 + Delta * Alpha
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
	Color3 = Color3Lerp;
	NumberRange = function(V0, V1)
		local Min0, Max0 = V0.Min, V0.Max
		local DeltaMin, DeltaMax = V1.Min - Min0, V1.Max - Max0

		return function(Alpha)
			return NumberRange.new(Min0 + Alpha * DeltaMin, Max0 + Alpha * DeltaMax)
		end
	end;

	NumberSequenceKeypoint = function(V0, V1)
		local T0, Value0, E0 = V0.Time, V0.Value, V0.Envelope
		local DT, DV, DE = V1.Time - T0, V1.Value - Value0, V1.Envelope - E0

		return function(Alpha)
			return NumberSequenceKeypoint.new(T0 + Alpha * DT, Value0 + Alpha * DV, E0 + Alpha * DE)
		end
	end;

	PhysicalProperties = function(V0, V1)
		local D0, E0, EW0, F0, FW0 =
			V0.Density, V0.Elasticity,
		V0.ElasticityWeight, V0.Friction,
		V0.FrictionWeight

		local DD, DE, DEW, DF, DFW =
			V1.Density - D0, V1.Elasticity - E0,
		V1.ElasticityWeight - EW0, V1.Friction - F0,
		V1.FrictionWeight - FW0

		return function(Alpha)
			return PhysicalProperties.new(
				D0 + Alpha * DD,
				E0 + Alpha * DE, EW0 + Alpha * DEW,
				F0 + Alpha * DF, FW0 + Alpha * DFW
			)
		end
	end;

	Ray = function(V0, V1)
		local O0, D0, O1, D1 = V0.Origin, V0.Direction, V1.Origin, V1.Direction
		local OX0, OY0, OZ0, DX0, DY0, DZ0 = O0.X, O0.Y, O0.Z, D0.X, D0.Y, D0.Z
		local DOX, DOY, DOZ, DDX, DDY, DDZ = O1.X - OX0, O1.Y - OY0, O1.Z - OZ0, D1.X - DX0, D1.Y - DY0, D1.Z - DZ0

		return function(Alpha)
			return Ray.new(
				Vector3.new(OX0 + Alpha * DOX, OY0 + Alpha * DOY, OZ0 + Alpha * DOZ),
				Vector3.new(DX0 + Alpha * DDX, DY0 + Alpha * DDY, DZ0 + Alpha * DDZ)
			)
		end
	end;

	UDim = function(V0, V1)
		local SC, OF = V0.Scale, V0.Offset
		local DSC, DOF = V1.Scale - SC, V1.Offset - OF

		return function(Alpha)
			return UDim.new(SC + Alpha * DSC, OF + Alpha * DOF)
		end
	end;

	UDim2 = RobloxLerp;
	Vector2 = RobloxLerp;
	Vector3 = RobloxLerp;
	Rect = function(V0, V1)
		return function(Alpha)
			return Rect.new(
				V0.Min.X + Alpha * (V1.Min.X - V0.Min.X), V0.Min.Y + Alpha * (V1.Min.Y - V0.Min.Y),
				V0.Max.X + Alpha * (V1.Max.X - V0.Max.X), V0.Max.Y + Alpha * (V1.Max.Y - V0.Max.Y)
			)
		end
	end;

	Region3 = function(V0, V1)
		return function(Alpha)
			local imin = Lerp(V0.CFrame * (-V0.Size / 2), V1.CFrame * (-V1.Size / 2), Alpha)
			local imax = Lerp(V0.CFrame * (V0.Size / 2), V1.CFrame * (V1.Size / 2), Alpha)

			local iminx = imin.X
			local imaxx = imax.X
			local iminy = imin.Y
			local imaxy = imax.Y
			local iminz = imin.Z
			local imaxz = imax.Z

			return Region3.new(
				Vector3.new(iminx < imaxx and iminx or imaxx, iminy < imaxy and iminy or imaxy, iminz < imaxz and iminz or imaxz),
				Vector3.new(iminx > imaxx and iminx or imaxx, iminy > imaxy and iminy or imaxy, iminz > imaxz and iminz or imaxz)
			)
		end
	end;

	NumberSequence = function(V0, V1)
		return function(Alpha)
			local keypoints = {}
			local addedTimes = {}
			local keylength = 0

			for _, ap in ipairs(V0.Keypoints) do
				local closestAbove, closestBelow

				for _, bp in ipairs(V1.Keypoints) do
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
				keypoints[keylength] = NumberSequenceKeypoint.new(ap.Time, (bValue - ap.Value) * Alpha + ap.Value, (bEnvelope - ap.Envelope) * Alpha + ap.Envelope)
				addedTimes[ap.Time] = true
			end

			for _, bp in ipairs(V1.Keypoints) do
				if not addedTimes[bp.Time] then
					local closestAbove, closestBelow

					for _, ap in ipairs(V0.Keypoints) do
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
					keypoints[keylength] = NumberSequenceKeypoint.new(bp.Time, (bp.Value - aValue) * Alpha + aValue, (bp.Envelope - aEnvelope) * Alpha + aEnvelope)
				end
			end

			table.sort(keypoints, SortByTime)
			return NumberSequence.new(keypoints)
		end
	end;

	ColorSequence = function(V0, V1)
		return function(Alpha)
			local keypoints = {}
			local addedTimes = {}
			local keylength = 0

			for _, ap in ipairs(V0.Keypoints) do
				local closestAbove, closestBelow

				for _, bp in ipairs(V1.Keypoints) do
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
					bValue = Color3Lerp(closestBelow.Value, closestAbove.Value)((ap.Time - closestBelow.Time) / (closestAbove.Time - closestBelow.Time))
				end

				keylength += 1
				keypoints[keylength] = ColorSequenceKeypoint.new(ap.Time, Color3Lerp(ap.Value, bValue)(Alpha))
				addedTimes[ap.Time] = true
			end

			for _, bp in ipairs(V1.Keypoints) do
				if not addedTimes[bp.Time] then
					local closestAbove, closestBelow

					for _, ap in ipairs(V0.Keypoints) do
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
						aValue = Color3Lerp(closestBelow.Value, closestAbove.Value)((bp.Time - closestBelow.Time) / (closestAbove.Time - closestBelow.Time))
					end

					keylength += 1
					keypoints[keylength] = ColorSequenceKeypoint.new(bp.Time, Color3Lerp(bp.Value, aValue)(Alpha))
				end
			end

			table.sort(keypoints, SortByTime)
			return ColorSequence.new(keypoints)
		end
	end;
}, {
	__index = function(_, Index)
		error("No lerp function is defined for type " .. tostring(Index) .. ".", 4)
	end;

	__newindex = function(_, Index)
		error("No lerp function is defined for type " .. tostring(Index) .. ".", 4)
	end;
})

return Lerps
]]

 

local l_ipairs = ipairs;
local Color3_new_ret = Color3.new();

local function RobloxLerp(u1, u2) -- Line: 5
    return function(p3) -- Line: 6
        -- upvalues: u1 (copy), u2 (copy)
        return u1:Lerp(u2, p3);
    end;
end;

local function Lerp(p4, p5, p6) -- Line: 11
    return p4 + p6 * (p5 - p4);
end;

local function SortByTime(p7, p8) -- Line: 15
    return p7.Time < p8.Time;
end;

local function Color3Lerp(p9, p10) -- Line: 19
    -- upvalues: Color3_new_ret (copy)
    local R = p9.R;
    local G = p9.G;
    local B = p9.B;
    local v11 = R < 0.0404482362771076 and R / 12.92 or 0.87941546140213 * (R + 0.055) ^ 2.4;
    local v12 = G < 0.0404482362771076 and G / 12.92 or 0.87941546140213 * (G + 0.055) ^ 2.4;
    local v13 = B < 0.0404482362771076 and B / 12.92 or 0.87941546140213 * (B + 0.055) ^ 2.4;
    local v14 = 0.2125862307855956 * v11 + 0.7151703037034108 * v12 + 0.0722004986433362 * v13;
    local v15 = 3.6590806972265884 * v11 + 11.442689580057424 * v12 + 4.114991502426484 * v13;
    local u16 = v14 > 0.008856451679035631 and 116 * v14 ^ 0.3333333333333333 - 16 or 903.296296296296 * v14;
    local u17, u18;

    if v15 > 1e-15 then
        u17 = u16 * (0.9257063972951867 * v11 - 0.8333736323779866 * v12 - 0.09209820666085898 * v13) / v15;
        u18 = u16 * (9 * v14 / v15 - 0.46832);
    else
        u17 = -0.19783 * u16;
        u18 = -0.46832 * u16;
    end;

    local R2 = p10.R;
    local G2 = p10.G;
    local B2 = p10.B;
    local v19 = R2 < 0.0404482362771076 and R2 / 12.92 or 0.87941546140213 * (R2 + 0.055) ^ 2.4;
    local v20 = G2 < 0.0404482362771076 and G2 / 12.92 or 0.87941546140213 * (G2 + 0.055) ^ 2.4;
    local v21 = B2 < 0.0404482362771076 and B2 / 12.92 or 0.87941546140213 * (B2 + 0.055) ^ 2.4;
    local v22 = 0.2125862307855956 * v19 + 0.7151703037034108 * v20 + 0.0722004986433362 * v21;
    local v23 = 3.6590806972265884 * v19 + 11.442689580057424 * v20 + 4.114991502426484 * v21;
    local u24 = v22 > 0.008856451679035631 and 116 * v22 ^ 0.3333333333333333 - 16 or 903.296296296296 * v22;
    local u25, u26;

    if v23 > 1e-15 then
        u25 = u24 * (0.9257063972951867 * v19 - 0.8333736323779866 * v20 - 0.09209820666085898 * v21) / v23;
        u26 = u24 * (9 * v22 / v23 - 0.46832);
    else
        u25 = -0.19783 * u24;
        u26 = -0.46832 * u24;
    end;

    return function(p27) -- Line: 54
        -- upvalues: u16 (ref), u24 (ref), Color3_new_ret (ref), u17 (ref), u25 (ref), u18 (ref), u26 (ref)
        local v28 = (1 - p27) * u16 + p27 * u24;

        if v28 < 0.0197955 then
            return Color3_new_ret;
        end;

        local v29 = ((1 - p27) * u17 + p27 * u25) / v28 + 0.19783;
        local v30 = ((1 - p27) * u18 + p27 * u26) / v28 + 0.46832;
        local v31 = (v28 + 16) / 116;
        local v32 = v31 > 0.20689655172413793 and v31 * v31 * v31 or 0.12841854934601665 * v31 - 0.01771290335807126;
        local v33 = v32 * v29 / v30;
        local v34 = v32 * ((3 - 0.75 * v29) / v30 - 5);
        local v35 = 7.2914074 * v33 - 1.537208 * v32 - 0.4986286 * v34;
        local v36 = -2.180094 * v33 + 1.8757561 * v32 + 0.0415175 * v34;
        local v37 = 0.1253477 * v33 - 0.2040211 * v32 + 1.0569959 * v34;

        if v35 < 0 and (v35 < v36 and v35 < v37) then
            v36 = v36 - v35;
            v37 = v37 - v35;
            v35 = 0;
        elseif v36 < 0 and v36 < v37 then
            v35 = v35 - v36;
            v37 = v37 - v36;
            v36 = 0;
        elseif v37 < 0 then
            v35 = v35 - v37;
            v36 = v36 - v37;
            v37 = 0;
        end;

        local v38 = v35 < 0.0031306684425 and 12.92 * v35 or 1.055 * v35 ^ 0.4166666666666667 - 0.055;
        local v39 = v36 < 0.0031306684425 and 12.92 * v36 or 1.055 * v36 ^ 0.4166666666666667 - 0.055;
        local v40 = v37 < 0.0031306684425 and 12.92 * v37 or 1.055 * v37 ^ 0.4166666666666667 - 0.055;

        return Color3.new(v38 > 1 and 1 or (v38 < 0 and 0 or v38), v39 > 1 and 1 or (v39 < 0 and 0 or v39), v40 > 1 and 1 or (v40 < 0 and 0 or v40));
    end;
end;

return setmetatable({
    boolean = function(u41, u42) -- Line: 93, Name: boolean
        return function(p43) -- Line: 94
            -- upvalues: u41 (copy), u42 (copy)
            if p43 < 0.5 then
                return u41;
            end;

            return u42;
        end;
    end,

    number = function(u44, p45) -- Line: 103, Name: number
        local u46 = p45 - u44;

        return function(p47) -- Line: 105
            -- upvalues: u44 (copy), u46 (copy)
            return u44 + u46 * p47;
        end;
    end,

    string = function(p48, u49) -- Line: 110, Name: string
        local v50 = false;
        local string_match_ret, v51, v52, v53 = string.match(p48, "^([+-]?)(%d*):[+-]?(%d*):[+-]?(%d*)$");
        local string_match_ret2, v54, v55, v56 = string.match(u49, "^([+-]?)(%d*):[+-]?(%d*):[+-]?(%d*)$");
        local u57, u58;

        if string_match_ret and string_match_ret2 then
            u57 = 3600 * (tonumber(v51) or 0) + 60 * (tonumber(v52) or 0) + (tonumber(v53) or 0);
            local v59 = 3600 * (tonumber(v54) or 0) + 60 * (tonumber(v55) or 0) + (tonumber(v56) or 0);

            if string_match_ret == "-" then
                u57 = -u57;
            end;

            if string_match_ret2 == "-" or not v59 then
                v59 = -v59;
            end;

            u58 = (43200 + v59 - u57) % 86400 - 43200;
        else
            v50 = true;
            u57 = nil;
            u58 = nil;
        end;

        if not v50 then
            return function(p60) -- Line: 136
                -- upvalues: u57 (ref), u58 (ref)
                local v61 = (u57 + u58 * p60) % 86400;
                local math_abs_ret = math.abs(v61);

                return string.format(v61 < 0 and "-%.2u:%.2u:%.2u" or "%.2u:%.2u:%.2u", (math_abs_ret - math_abs_ret % 3600) / 3600, (math_abs_ret % 3600 - math_abs_ret % 60) / 60, math_abs_ret % 60);
            end;
        end;

        local u62 = #u49;

        return function(p63) -- Line: 131
            -- upvalues: u62 (copy), u49 (copy)
            local v64 = 1 + u62 * p63;

            return string.sub(u49, 1, v64 < u62 and v64 and v64 or u62);
        end;
    end,

    CFrame = RobloxLerp,
    Color3 = Color3Lerp,

    NumberRange = function(p65, p66) -- Line: 151, Name: NumberRange
        local Min = p65.Min;
        local Max = p65.Max;
        local u67 = p66.Min - Min;
        local u68 = p66.Max - Max;

        return function(p69) -- Line: 155
            -- upvalues: Min (copy), u67 (copy), Max (copy), u68 (copy)
            return NumberRange.new(Min + p69 * u67, Max + p69 * u68);
        end;
    end,

    NumberSequenceKeypoint = function(p70, p71) -- Line: 160, Name: NumberSequenceKeypoint
        local Time = p70.Time;
        local Value = p70.Value;
        local Envelope = p70.Envelope;
        local u72 = p71.Time - Time;
        local u73 = p71.Value - Value;
        local u74 = p71.Envelope - Envelope;

        return function(p75) -- Line: 164
            -- upvalues: Time (copy), u72 (copy), Value (copy), u73 (copy), Envelope (copy), u74 (copy)
            return NumberSequenceKeypoint.new(Time + p75 * u72, Value + p75 * u73, Envelope + p75 * u74);
        end;
    end,

    PhysicalProperties = function(p76, p77) -- Line: 169, Name: PhysicalProperties
        local Density = p76.Density;
        local Elasticity = p76.Elasticity;
        local ElasticityWeight = p76.ElasticityWeight;
        local Friction = p76.Friction;
        local FrictionWeight = p76.FrictionWeight;
        local u78 = p77.Density - Density;
        local u79 = p77.Elasticity - Elasticity;
        local u80 = p77.ElasticityWeight - ElasticityWeight;
        local u81 = p77.Friction - Friction;
        local u82 = p77.FrictionWeight - FrictionWeight;

        return function(p83) -- Line: 180
            -- upvalues: Density (copy), u78 (copy), Elasticity (copy), u79 (copy), ElasticityWeight (copy), u80 (copy), Friction (copy), u81 (copy), FrictionWeight (copy), u82 (copy)
            return PhysicalProperties.new(Density + p83 * u78, Elasticity + p83 * u79, ElasticityWeight + p83 * u80, Friction + p83 * u81, FrictionWeight + p83 * u82);
        end;
    end,

    Ray = function(p84, p85) -- Line: 189, Name: Ray
        local Origin = p84.Origin;
        local Direction = p84.Direction;
        local Origin2 = p85.Origin;
        local Direction2 = p85.Direction;
        local X = Origin.X;
        local Y = Origin.Y;
        local Z = Origin.Z;
        local X2 = Direction.X;
        local Y2 = Direction.Y;
        local Z2 = Direction.Z;
        local u86 = Origin2.X - X;
        local u87 = Origin2.Y - Y;
        local u88 = Origin2.Z - Z;
        local u89 = Direction2.X - X2;
        local u90 = Direction2.Y - Y2;
        local u91 = Direction2.Z - Z2;

        return function(p92) -- Line: 194
            -- upvalues: X (copy), u86 (copy), Y (copy), u87 (copy), Z (copy), u88 (copy), X2 (copy), u89 (copy), Y2 (copy), u90 (copy), Z2 (copy), u91 (copy)
            return Ray.new(Vector3.new(X + p92 * u86, Y + p92 * u87, Z + p92 * u88), (Vector3.new(X2 + p92 * u89, Y2 + p92 * u90, Z2 + p92 * u91)));
        end;
    end,

    UDim = function(p93, p94) -- Line: 202, Name: UDim
        local Scale = p93.Scale;
        local Offset = p93.Offset;
        local u95 = p94.Scale - Scale;
        local u96 = p94.Offset - Offset;

        return function(p97) -- Line: 206
            -- upvalues: Scale (copy), u95 (copy), Offset (copy), u96 (copy)
            return UDim.new(Scale + p97 * u95, Offset + p97 * u96);
        end;
    end,

    UDim2 = RobloxLerp,
    Vector2 = RobloxLerp,
    Vector3 = RobloxLerp,

    Rect = function(u98, u99) -- Line: 214, Name: Rect
        return function(p100) -- Line: 215
            -- upvalues: u98 (copy), u99 (copy)
            return Rect.new(u98.Min.X + p100 * (u99.Min.X - u98.Min.X), u98.Min.Y + p100 * (u99.Min.Y - u98.Min.Y), u98.Max.X + p100 * (u99.Max.X - u98.Max.X), u98.Max.Y + p100 * (u99.Max.Y - u98.Max.Y));
        end;
    end,

    Region3 = function(u101, u102) -- Line: 223, Name: Region3
        return function(p103) -- Line: 224
            -- upvalues: u101 (copy), u102 (copy)
            local v104 = u101.CFrame * (-u101.Size / 2);
            local v105 = v104 + p103 * (u102.CFrame * (-u102.Size / 2) - v104);
            local v106 = u101.CFrame * (u101.Size / 2);
            local v107 = v106 + p103 * (u102.CFrame * (u102.Size / 2) - v106);
            local X = v105.X;
            local X2 = v107.X;
            local Y = v105.Y;
            local Y2 = v107.Y;
            local Z = v105.Z;
            local Z2 = v107.Z;
            local Region3_new = Region3.new;
            local Vector3_new_ret = Vector3.new(X < X2 and X and X or X2, Y < Y2 and Y and Y or Y2, Z < Z2 and Z and Z or Z2);

            if X2 < X then
                X2 = X or X2;
            end;

            if Y2 < Y then
                Y2 = Y or Y2;
            end;

            if Z2 < Z then
                Z2 = Z or Z2;
            end;

            return Region3_new(Vector3_new_ret, (Vector3.new(X2, Y2, Z2)));
        end;
    end,

    NumberSequence = function(u108, u109) -- Line: 242, Name: NumberSequence
        -- upvalues: l_ipairs (copy), SortByTime (copy)
        return function(p110) -- Line: 243
            -- upvalues: l_ipairs (ref), u108 (copy), u109 (copy), SortByTime (ref)
            local v111 = {};
            local v112 = 0;
            local v113 = {};

            for _, v in l_ipairs(u108.Keypoints) do
                local v114 = v;
                local v115 = nil;
                local v116 = nil;

                for _, v2 in l_ipairs(u109.Keypoints) do
                    if v2.Time == v114.Time then
                        v115 = v2;
                        v116 = v115;
                        local v117 = v115;
                        v115 = v116;
                        v117 = v116;
                        break;
                    end;

                    if v2.Time < v114.Time and (v115 == nil or v2.Time > v115.Time) then
                        v115 = v2;
                    elseif v2.Time > v114.Time and (v116 == nil or v2.Time < v116.Time) then
                        v116 = v2;
                    end;
                end;

                local v118, v119;

                if v116 == v115 then
                    v118 = v116.Value;
                    v119 = v116.Envelope;
                else
                    local v120 = (v114.Time - v115.Time) / (v116.Time - v115.Time);
                    v118 = (v116.Value - v115.Value) * v120 + v115.Value;
                    v119 = (v116.Envelope - v115.Envelope) * v120 + v115.Envelope;
                end;

                v112 = v112 + 1;
                v113[v112] = NumberSequenceKeypoint.new(v114.Time, (v118 - v114.Value) * p110 + v114.Value, (v119 - v114.Envelope) * p110 + v114.Envelope);
                v111[v114.Time] = true;
            end;

            for _, v in l_ipairs(u109.Keypoints) do
                if not v111[v.Time] then
                    local v121 = v;
                    local v122 = nil;
                    local v123 = nil;

                    for _, v2 in l_ipairs(u108.Keypoints) do
                        if v2.Time == v121.Time then
                            v122 = v2;
                            v123 = v122;
                            local v124 = v122;
                            v122 = v123;
                            v124 = v123;
                            break;
                        end;

                        if v2.Time < v121.Time and (v122 == nil or v2.Time > v122.Time) then
                            v122 = v2;
                        elseif v2.Time > v121.Time and (v123 == nil or v2.Time < v123.Time) then
                            v123 = v2;
                        end;
                    end;

                    local v125, v126;

                    if v123 == v122 then
                        v125 = v123.Value;
                        v126 = v123.Envelope;
                    else
                        local v127 = (v121.Time - v122.Time) / (v123.Time - v122.Time);
                        v125 = (v123.Value - v122.Value) * v127 + v122.Value;
                        v126 = (v123.Envelope - v122.Envelope) * v127 + v122.Envelope;
                    end;

                    v112 = v112 + 1;
                    v113[v112] = NumberSequenceKeypoint.new(v121.Time, (v121.Value - v125) * p110 + v125, (v121.Envelope - v126) * p110 + v126);
                end;
            end;

            table.sort(v113, SortByTime);

            return NumberSequence.new(v113);
        end;
    end,

    ColorSequence = function(u128, u129) -- Line: 310, Name: ColorSequence
        -- upvalues: l_ipairs (copy), Color3Lerp (copy), SortByTime (copy)
        return function(p130) -- Line: 311
            -- upvalues: l_ipairs (ref), u128 (copy), u129 (copy), Color3Lerp (ref), SortByTime (ref)
            local v131 = {};
            local v132 = 0;
            local v133 = {};

            for _, v in l_ipairs(u128.Keypoints) do
                local v134 = v;
                local v135 = nil;
                local v136 = nil;

                for _, v2 in l_ipairs(u129.Keypoints) do
                    if v2.Time == v134.Time then
                        v135 = v2;
                        v136 = v135;
                        local v137 = v135;
                        v135 = v136;
                        v137 = v136;
                        break;
                    end;

                    if v2.Time < v134.Time and (v135 == nil or v2.Time > v135.Time) then
                        v135 = v2;
                    elseif v2.Time > v134.Time and (v136 == nil or v2.Time < v136.Time) then
                        v136 = v2;
                    end;
                end;

                local v138;

                if v136 == v135 then
                    v138 = v136.Value;
                else
                    v138 = Color3Lerp(v135.Value, v136.Value)((v134.Time - v135.Time) / (v136.Time - v135.Time));
                end;

                v132 = v132 + 1;
                v133[v132] = ColorSequenceKeypoint.new(v134.Time, Color3Lerp(v134.Value, v138)(p130));
                v131[v134.Time] = true;
            end;

            for _, v in l_ipairs(u129.Keypoints) do
                if not v131[v.Time] then
                    local v139 = v;
                    local v140 = nil;
                    local v141 = nil;

                    for _, v2 in l_ipairs(u128.Keypoints) do
                        if v2.Time == v139.Time then
                            v140 = v2;
                            v141 = v140;
                            local v142 = v140;
                            v140 = v141;
                            v142 = v141;
                            break;
                        end;

                        if v2.Time < v139.Time and (v140 == nil or v2.Time > v140.Time) then
                            v140 = v2;
                        elseif v2.Time > v139.Time and (v141 == nil or v2.Time < v141.Time) then
                            v141 = v2;
                        end;
                    end;

                    local v143;

                    if v141 == v140 then
                        v143 = v141.Value;
                    else
                        v143 = Color3Lerp(v140.Value, v141.Value)((v139.Time - v140.Time) / (v141.Time - v140.Time));
                    end;

                    v132 = v132 + 1;
                    v133[v132] = ColorSequenceKeypoint.new(v139.Time, Color3Lerp(v139.Value, v143)(p130));
                end;
            end;

            table.sort(v133, SortByTime);

            return ColorSequence.new(v133);
        end;
    end
}, {
    __index = function(p144, p145) -- Line: 374, Name: __index
        error("No lerp function is defined for type " .. tostring(p145) .. ".", 4);
    end,

    __newindex = function(p146, p147) -- Line: 378, Name: __newindex
        error("No lerp function is defined for type " .. tostring(p147) .. ".", 4);
    end
});