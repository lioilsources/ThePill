package model

// JSON schémata pro vLLM guided decoding (přes LiteLLM response_format=json_schema).
// Model pak nemůže vrátit rozbitý JSON — zbývá jen sémantická validace.

func str() map[string]any { return map[string]any{"type": "string"} }

var schemas = map[string]map[string]any{
	"classify": obj(map[string]any{
		"tone":   map[string]any{"type": "string", "enum": []string{"ok", "tense", "hostile", "manipulative"}},
		"score":  map[string]any{"type": "number", "minimum": 0, "maximum": 1},
		"reason": str(),
	}),
	"soften": obj(map[string]any{
		"text_soft":  str(),
		"kept_facts": map[string]any{"type": "array", "items": str()},
	}),
	"coach": obj(map[string]any{
		"is_hostile":   map[string]any{"type": "boolean"},
		"why":          str(),
		"alternatives": map[string]any{"type": "array", "items": str(), "maxItems": 2},
	}),
}

func obj(props map[string]any) map[string]any {
	req := make([]string, 0, len(props))
	for k := range props {
		req = append(req, k)
	}
	return map[string]any{"type": "object", "properties": props, "required": req, "additionalProperties": false}
}

func responseFormat(op string) any {
	sc, ok := schemas[op]
	if !ok {
		return map[string]string{"type": "json_object"}
	}
	return map[string]any{
		"type":        "json_schema",
		"json_schema": map[string]any{"name": op, "schema": sc, "strict": true},
	}
}
