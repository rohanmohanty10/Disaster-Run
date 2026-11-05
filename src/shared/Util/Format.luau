--!strict
-- Small text formatting helpers for UI.

local Format = {}

-- 1300000 -> "1,300,000"
function Format.Commas(value: number): string
	local negative = value < 0
	local digits = tostring(math.floor(math.abs(value)))
	local formatted = digits:reverse():gsub("(%d%d%d)", "%1,"):reverse()
	if formatted:sub(1, 1) == "," then
		formatted = formatted:sub(2)
	end
	return (if negative then "-" else "") .. formatted
end

-- 1300000 -> "$1,300,000"
function Format.Cash(value: number): string
	return "$" .. Format.Commas(value)
end

-- 0.25 -> "25", 0.0049 -> "0.49", 0.00005 -> "0.005" (percent, rounded for display)
function Format.Percent(chance: number): string
	local percent = chance * 100
	local text
	if percent >= 10 then
		text = string.format("%.1f", percent)
	elseif percent >= 0.1 then
		text = string.format("%.2f", percent)
	else
		text = string.format("%.4f", percent)
	end
	text = text:gsub("0+$", ""):gsub("%.$", "")
	return text
end

return Format
