package utils

import (
	"encoding/json"
	"fmt"
	"strconv"
)

// TryParseArgs attempts to parse method arguments from string.
//
// Supported are string, int, float64, bool, and slice of these types.
func TryParseArgs(args string) ([]string, error) {
	var i interface{}

	if err := json.Unmarshal([]byte(args), &i); err != nil {
		return nil, fmt.Errorf("failed encoding arguments: %w", err)
	}

	switch v := i.(type) {
	case string, int, float64, bool:
		return []string{argToString(v)}, nil
	case []interface{}:
		var argsSlice []string
		for j := range v {
			argsSlice = append(argsSlice, argToString(v[j]))
		}
		return argsSlice, nil
	case nil:
		return []string{}, nil
	default:
		return nil, fmt.Errorf("unsupported method argument type")
	}
}

func argToString(i interface{}) string {
	switch v := i.(type) {
	case string:
		return v
	case int:
		return strconv.Itoa(v)
	case float64:
		return fmt.Sprintf("%f", v)
	case bool:
		return strconv.FormatBool(v)
	default:
		j, _ := json.Marshal(v)
		return string(j)
	}
}
