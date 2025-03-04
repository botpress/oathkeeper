package main

import (
	"fmt"
	"os"

	"github.com/ory/oathkeeper/cmd"
)

func main() {
	if err := Generate(cmd.RootCmd, os.Args[1:]); err != nil {
		_, _ = fmt.Fprintf(os.Stderr, "%+v", err)
		os.Exit(1)
	}
	fmt.Println("All files have been generated and updated.")
}
