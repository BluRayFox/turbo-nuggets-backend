# Configuration

This section explains how to configure your server.

All server settings are defined in the `config.lua` file. This file contains the configurable options used by the server. Below is an explanation of each available option.

## `debug`

Enables debug mode when set to `true`. This is typically useful for developers who are modifying or troubleshooting the server’s internal functionality.

## `port`

Specifies the port that the server listener will use.

## `rateLimit`

Defines the maximum number of requests allowed per second from a single IP address. If this limit is exceeded, the IP address will be blocked and further requests will not be processed.

## `rateLimitTimer`

Determines how long (in seconds) an IP address remains blacklisted after exceeding the rate limit.
