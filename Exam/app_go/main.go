package main

import (
	"github.com/gin-gonic/contrib/static"
	"github.com/gin-gonic/gin"
)

func main() {
	// Default Gin router
	router := gin.Default()

	// Serve the frontend via views folder
	router.Use(static.Serve("/", static.LocalFile("./views", true)))

	// Setup homepage route
	router.GET("/", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "pong",
		})
	})

	// Start the app via localhost
	router.Run(":3012")
}
