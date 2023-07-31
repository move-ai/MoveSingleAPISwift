// @generated
// This file was automatically generated and can be edited to
// implement advanced custom scalar functionality.
//
// Any changes to this file will not be overwritten by future
// code generation execution.

import ApolloAPI

/// The `AWSURL` scalar type provided by AWS AppSync, represents a valid URL string (Ex: <https://www.amazon.com/>). The URL may use any scheme and may also be a local URL (Ex: <http://localhost/>).  URLs without schemes like "**amazon.com**" or "**www.amazon.com**" are considered invalid. URLs which contain double slashes (two consecutive forward slashes) in their path are also considered invalid.
public typealias AWSURL = String
