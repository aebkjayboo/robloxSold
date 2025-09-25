local HttpService = game:GetService("HttpService")

local DiscordWebhook = {}

function DiscordWebhook:Send(webhookUrl, messageData)
	if type(messageData) == "string" then
		messageData = { content = messageData }
	end

	local ok, err = pcall(function()
		http_request({
			Url = webhookUrl,
			Method = "POST",
			Headers = { ["Content-Type"] = "application/json" },
			Body = HttpService:JSONEncode(messageData),
		})
	end)

	if not ok then
		warn("DiscordWebhook failed to send:", err)
	end
end

function DiscordWebhook:Embed(title, description, color, thumbnail, image, fields)
	return {
		embeds = {
			{
				title = title or "",
				description = description or "",
				color = color or 0,
				thumbnail = thumbnail and { url = thumbnail } or nil,
				image = image and { url = image } or nil,
				timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
				fields = fields or {},
			}
		}
	}
end

return DiscordWebhook
