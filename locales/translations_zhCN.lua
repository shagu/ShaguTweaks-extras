local translation = {
  ["Extras:"] = "额外：",

  ["Action Bar"] = "动作条",

  ["Center Vertical Actionbar"] = "垂直动作条居中",
  ["Center the vertical actionbar on the right side."] = "将右侧垂直动作条居中显示。",

  ["Dragonflight Gryphons"] = "巨龙时代狮鹫",
  ["Replaces actionbar gryphons with the dragonflight version."] = "将动作条狮鹫替换为巨龙时代版本。",

  ["Floating Actionbar"] = "浮动动作条",
  ["Removes all background textures and lets the actionbar float."] = "移除所有背景纹理，使动作条浮动显示。",

  ["Reagent Counter"] = "材料计数器",
  ["Shows a reagent counter on action buttons."] = "在动作条按钮上显示材料数量。",

  ["Show Bags"] = "显示背包",
  ["Shows bag and keyring buttons when using the reduced actionbar layout. Hold Ctrl+Shift to move the bag bar."] = "精简动作条布局时显示背包按钮，按住Ctrl+Shift可移动背包栏。",
  
  ["Show Micro Menu"] = "显示微型菜单",
  ["Shows micro menu buttons when using the reduced actionbar layout. Hold Ctrl+Shift to move the micro menu."] = "精简动作条布局时显示微型菜单按钮，按住Ctrl+Shift可移动菜单。",

  ["Chat"] = "聊天",

  ["Center Text Input Box"] = "居中文本输入框",
  ["Move the chat input box to the center of the screen."] = "将聊天输入框移动到屏幕中心位置。",

  ["Chat History"] = "聊天记录",
  ["Save chat history of all non-combatlog windows and restore it on login."] = "保存所有非战斗日志窗口的聊天记录，并在登录时恢复。",

  ["Chat Timestamps"] = "聊天时间戳",
  ["Add timestamps to chat messages."] = "为聊天消息添加时间戳。",

  ["Enable Text Shadow"] = "启用文字阴影",
  ["Enable text shadow in all chat frames."] = "在所有聊天框中启用文字阴影效果。",

  ["Macro"] = "宏",

  ["Macro Icons"] = "宏图标",
  ["Detect showtooltip and spells in macros to use them on action buttons."] = "检测宏中的#showtooltip和法术，用于动作按钮图标。",

  ["Macro Tweaks"] = "宏功能调整",
  ["Add /equip command to macros, remove #showtooltip from chat and hide macro commands from history."] = "在宏中添加/equip命令，从聊天中移除#showtooltip并隐藏宏命令历史。",

  ["Raid Frames"] = "团队框架",

  ["Enable Raid Frames"] = "启用团队框架",
  ["Very simple raid frames with only the most basic features."]= "简洁的团队框架，仅包含基础功能。",

  ["Hide Party Frames"] = "隐藏小队框架",
  ["Disable default party frames while the raidframes are active."] = "团队框架启用时禁用默认小队框架。",

  ["Show Aggro Indicators"] = "显示仇恨指示器",
  ["Show indicators on raid members that are currently attacked by other units. (This only works if the unit is a target of a raid member)"] = "为被攻击的团队成员显示仇恨指示器。（仅当目标是团队成员时才生效）",

  ["Show Combat Feedback"] = "显示战斗反馈",
  ["Show combat feedback numbers on health bars."] = "在生命条上显示战斗伤害/治疗数值。",

  ["Show Dispel Indicators"] = "显示驱散指示器",
  ["Show indicators for units affected by curse, magic, poison or diseases based on your class."] = "根据职业为受诅咒、魔法、中毒或疾病影响的单位显示驱散指示器。",

  ["Show Group Headers"] = "显示小队标题",
  ["Display group headers on raid frames"] = "在团队框架上显示小队标题",

  ["Show Healing Predictions"] = "显示治疗预判",
  ["Show healing predictions that are received in a healcomm compatible protocol."] = "通过healcomm协议显示即将到来的治疗量预判。",

  ["Use As Party Frames"] = "用作小队框架",
  ["Use raid frames to display party members in regular groups"] = "在普通队伍中使用团队框架显示队员",

  ["Use Compact Layout"] = "使用紧凑布局",
  ["Reduces the raid frame size and the displayed elements. As a healer, you should never use this layout."] = "缩小团队框架尺寸并减少显示元素。治疗职业请勿使用此布局。",

  -- 常规

  ["Bag Item Click"] = "背包物品点击功能",
  ["Send items to trade window or auction house search via right click."] = "通过右键点击将物品发送到交易窗口或拍卖行搜索框。",
 
  ["Bag Search Bar"] = "背包搜索栏",
  ["Adds a search field to the bag which allows you to search bag, keyring and bank slots."] = "在背包中添加搜索栏，可搜索背包、钥匙链及银行物品。",

  ["Reveal World Map"] = "揭示世界地图",
  ["Reveals unexplored world map areas and shows exploration hints."] = "揭示未探索区域并提供探索提示。",

  ["Show Energy Ticks"] = "显示能量刻度",
  ["Show energy and mana ticks on the player unit frame."] = "在玩家单位框架上显示能量/法力恢复刻度。",
}

for k, v in pairs(translation) do
  ShaguTweaks_translation["zhCN"][k] = v
end