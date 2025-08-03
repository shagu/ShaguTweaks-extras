local _G = ShaguTweaks.GetGlobalEnv()
local T = ShaguTweaks.T
local libtipscan = ShaguTweaks.libtipscan
local GetItemCount = ShaguTweaks.GetItemCount

local module = ShaguTweaks:register({
  title = T["Reagent Counter"],
  description = T["Shows a reagent counter on action buttons."],
  expansions = { ["vanilla"] = true, ["tbc"] = false },
  maintainer = "@shagu (GitHub)",
  category = T["Action Bar"],
  enabled = nil,
})

module.enable = function(self)
  local reagent_slots = { }
  local reagent_counts = { }
  local reagent_capture = SPELL_REAGENTS.."(.+)"
  local bars = { "Action", "BonusAction", "MultiBarBottomLeft", "MultiBarBottomRight", "MultiBarLeft", "MultiBarRight" }
  local scanner = libtipscan:GetScanner("reagents")

  local reagentcounter = CreateFrame("Frame", "ShaguTweaksReagentCount", UIParent)
  reagentcounter:RegisterEvent("PLAYER_ENTERING_WORLD")
  reagentcounter:RegisterEvent("ACTIONBAR_SLOT_CHANGED")
  reagentcounter:RegisterEvent("ACTIONBAR_PAGE_CHANGED")
  reagentcounter:RegisterEvent("UPDATE_BONUS_ACTIONBAR")
  reagentcounter:RegisterEvent("BAG_UPDATE")

  reagentcounter:SetScript("OnEvent", function()
    this.event = true
  end)

  reagentcounter:SetScript("OnUpdate", function()
    if not this.event then return end

    -- update all slots after each event
    for slot = 1, 120 do
      reagentcounter.ScanSlot(slot)
    end

    -- scan for all reagent item counts
    for item in pairs(reagent_counts) do
      reagent_counts[item] = GetItemCount(item)
    end

    -- update all actionbar buttons
    for _, prefix in pairs(bars) do
      for i = 1, NUM_ACTIONBAR_BUTTONS do
        local button = _G[prefix .. "Button" .. i]
        local text = _G[button:GetName().."Count"]
        local slot = ActionButton_GetPagedID(button)

        if reagent_slots[slot] then
          text:SetText(reagent_counts[reagent_slots[slot]])
        elseif not IsConsumableAction(slot) then
          text:SetText()
        end
      end
    end

    -- remove event trigger
    this.event = nil
  end)

  reagentcounter.ScanSlot = function(slot)
    local texture = GetActionTexture(slot)

    -- update buttons that previously had an reagent
    if reagent_slots[slot] and not HasAction(slot) then
      reagent_slots[slot] = nil
    end

    -- search for reagent requirements
    if HasAction(slot) then
      scanner:SetAction(slot)
      local _, reagents = scanner:Find(reagent_capture)
      -- remove reagent counts if existing
      reagents = reagents and string.gsub(reagents, " %((.+)%)", "")

      -- update on reagent requirement changes
      if reagents and reagent_slots[slot] ~= reagents then
        reagent_counts[reagents] = reagent_counts[reagents] or 0
        reagent_slots[slot] = reagents
      end
    end
  end
end
