local _G = ShaguTweaks.GetGlobalEnv()
local T = ShaguTweaks.T
 
local module = ShaguTweaks:register({
  title = T["Macro Tweaks"],
  description = T["Add /equip command to macros, remove #showtooltip from chat and hide macro commands from history."],
  expansions = { ["vanilla"] = true, ["tbc"] = false },
  maintainer = "@shagu (GitHub)",
  category = T["Macro"],
  enabled = true,
})
 
module.enable = function(self)
  -- make sure #showtooltip inside macros won't be sent
  local hookSendChatMessage = SendChatMessage
  function _G.SendChatMessage(msg, ...)
    if msg and string.find(msg, "^#showtooltip ") then return end
    hookSendChatMessage(msg, unpack(arg))
  end
 
  -- do not write macro calls into chat input history
  if not ChatFrameEditBox._AddHistoryLine then
    local userinput
 
    ChatFrameEditBox._AddHistoryLine = ChatFrameEditBox.AddHistoryLine
    ChatFrameEditBox.AddHistoryLine = function(self, text)
      if not userinput and text and string.find(text, "^/run(.+)") then return end
      if not userinput and string.find(text, "^/script(.+)") then return end
      if not userinput and string.find(text, "^/cast(.+)") then return end
      ChatFrameEditBox._AddHistoryLine(self, text)
    end
 
    local OnEnter = ChatFrameEditBox:GetScript("OnEnterPressed")
    ChatFrameEditBox:SetScript("OnEnterPressed", function(a1,a2,a3,a4)
      userinput = true
      OnEnter(a1,a2,a3,a4)
     userinput = nil
    end)
  end
 
  -- add /use and /equip to the macro api:
  -- https://wowwiki.fandom.com/wiki/Making_a_macro
  -- supported arguments:
  --   /use <itemname>
  --   /use <inventory slot>
  --   /use <bag> <slot>
  --   /equip <mainhand weapon name>
  --   /equipoff <offhand weapon name>
  _G.SLASH_EQUIP1 = "/equip"
  _G.SLASH_EQUIP2 = "/use"
  _G.SLASH_EQUIPOFF1 = "/equipoff"

  -- Check if item is available in bag
  local function FindItem(itemName)
  for bag = 0, 4 do
      for slot = 1, GetContainerNumSlots(bag) do
      local itemLink = GetContainerItemLink(bag, slot)
      if itemLink and string.find(itemLink, itemName) then
          return bag, slot
      end
      end
  end
  end
 
  _G.SlashCmdList.EQUIP = function (msg)
    if not msg or msg == "" then return end
    local bag, slot, _
    if string.find(msg, "%d+%s+%d+") then
      _, _, bag, slot = string.find(msg, "(%d+)%s+(%d+)")
    elseif string.find(msg, "%d+") then
      _, _, slot = string.find(msg, "(%d+)")
    else
      bag, slot = FindItem(msg)
    end
 
    if bag and slot then
      UseContainerItem(bag, slot)
    elseif not bag and slot then
      UseInventoryItem(slot)
    end
  end
 
  _G.SlashCmdList.EQUIPOFF = function (msg)
    if not msg or msg == "" then return end
    local bag, slot = FindItem(msg)
    
    if bag and slot then
      -- Equip item to offhand slot (slot 17)
      PickupContainerItem(bag, slot)
      EquipCursorItem(17)
    end
  end
end
