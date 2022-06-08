package x

func OrDefaultString(val, defaultVal string) string {
	if val == "" {
		return defaultVal
	}
	return val
}

func IfThenElseString(c bool, thenVal, elseVal string) string {
	if c {
		return thenVal
	}
	return elseVal
}

func IfThenElseWithDefaultString(c bool, thenVal, defaultVal string) string {
	return IfThenElseString(c, OrDefaultString(thenVal, defaultVal), defaultVal)
}
