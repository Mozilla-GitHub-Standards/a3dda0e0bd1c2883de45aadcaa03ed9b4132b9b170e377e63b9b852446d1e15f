Feature: Test Runs

    Scenario: Add components to a product, and check testrun for those components
        Given I create the seed company and product with these names:
            | company name    | product name  |
            | Massive Dynamic | Cortexiphan   |
        And I add the following components to that product:
            | name     | description      |
            | chunk    | The chunky part  |
            | squish   | The squishy part |
        And I create the following new testcycles:
            | name          | description               | product name | startDate  | endDate    | communityAuthoringAllowed | communityAccessAllowed |
            | Baroque Cycle | Ahh, the cycle of life... | Cortexiphan  | 2011/02/02 | 2012/02/02 | true                      | true                   |
        And I create a new testrun with name "Running Man" with testcycle "Baroque Cycle"
        Then that testrun has the following components:
            | name     | description      |
            | chunk    | The chunky part  |
            | squish   | The squishy part |

    Scenario: Retest a testrun, after it was run once - retest all cases
        Given I create the seed company and product with these names:
            | company name    | product name  |
            | Massive Dynamic | Cortexiphan   |
        When I create a new user with name "Capn Admin"
        And I activate the user with that name
        And I create a new role with name "Approvationalist" with the following permissions:
            | permissionCode               |
            | PERMISSION_TEST_CASE_EDIT    |
            | PERMISSION_TEST_CASE_APPROVE |
            | PERMISSION_TEST_RUN_ASSIGNMENT_EXECUTE |
        And I add the role with name "Approvationalist" to the user with that name
        When the user with that name creates a new testcase with name "Passing tc"
        And when I add these steps to the testcase with that name:
            | name      | stepNumber | estimatedTimeInMin | instruction    | expectedResult        |
            | Mockery   | 1          | 5                  | Go this way    | They went this way    |
        When the user with that name creates a new testcase with name "Another Passing tc"
        And when I add these steps to the testcase with that name:
            | name      | stepNumber | estimatedTimeInMin | instruction    | expectedResult        |
            | Mockery   | 1          | 5                  | Go this way    | They went this way    |
        When the user with that name creates a new testcase with name "Failing tc"
        And when I add these steps to the testcase with that name:
            | name      | stepNumber | estimatedTimeInMin | instruction    | expectedResult        |
            | Mockery   | 1          | 5                  | Go this way    | They went this way    |
        When the user with that name creates a new testcase with name "Invalidisimo"
        And when I add these steps to the testcase with that name:
            | name      | stepNumber | estimatedTimeInMin | instruction    | expectedResult        |
            | Mockery   | 1          | 5                  | Go this way    | They went this way    |
        Then when I create a new user with name "Joe Tester"
        And I activate the user with that name
        And I add the role with name "Approvationalist" to the user with that name
        And when the user with name "Joe Tester" approves the following testcases:
            | name               |
            | Passing tc         |
            | Another Passing tc |
            | Failing tc         |
            | Invalidisimo       |
        And I activate the following testcases
            | name               |
            | Passing tc         |
            | Another Passing tc |
            | Failing tc         |
            | Invalidisimo       |
        And I create the following new testsuites:
            | name          | description               | product name | useLatestVersions |
            | Sweet Suite   | Ahh, the cycle of life... | Cortexiphan  | true              |
        And I add the following testcases to the testsuite with name "Sweet Suite":
            | name               |
            | Passing tc         |
            | Another Passing tc |
            | Failing tc         |
            | Invalidisimo       |
        And I activate the testsuite with name "Sweet Suite"
        And when I create the following new testcycles:
            | name          | description               | product name | startDate  | endDate    | communityAuthoringAllowed | communityAccessAllowed |
            | Baroque Cycle | Ahh, the cycle of life... | Cortexiphan  | 2011/02/02 | 2012/02/02 | true                      | true                   |
        And when I create a new testrun with name "Running Man" with testcycle "Baroque Cycle"
        And I create a new environmenttype with name "EnvType1"
        And I create a new environment with name "Env1" of type "EnvType1"
        And I create a new group environmenttype with name "GrpEnvType1"
        And I create a new environmentgroup with name "EnvGrp1" of type "GrpEnvType1"
        And I add the following environments to the environmentgroup with that name:
            | name |
            | Env1 |
        And I add the following users to the testrun with that name:
            | name         |
            | Joe Tester |
        And I add the following environmentgroups to the testrun with that name:
            | name    |
            | EnvGrp1 |
        And when I add the following testsuites to the testrun with that name
            | name    |
            | Sweet Suite  |
        And I activate the testcycle with name "Baroque Cycle"
        And I activate the testrun with that name
        And I assign the following testcases to the user with name "Joe Tester" for the testrun with name "Running Man"
            | name               |
            | Passing tc         |
            | Another Passing tc |
            | Failing tc         |
            | Invalidisimo       |
        And the user with that name marks the following testcase result statuses for the testrun with that name
            | name               | status      |
            | Passing tc         | Passed      |
            | Another Passing tc | Passed      |
            | Failing tc         | Failed      |
            | Invalidisimo       | Invalidated |
        When I call retest for that testrun
        Then the following testcases have the following result statuses for that testrun
            | name               | status   |
            | Passing tc         | Pending  |
            | Another Passing tc | Pending  |
            | Failing tc         | Pending  |
            | Invalidisimo       | Pending  |

    Scenario: Retest a completed testrun, failed only
        Given I create the seed company and product with these names:
            | company name    | product name  |
            | Massive Dynamic | Cortexiphan   |
        When I create a new user with name "Capn Admin"
        And I activate the user with that name
        And I create a new role with name "Approvationalist" with the following permissions:
            | permissionCode               |
            | PERMISSION_TEST_CASE_EDIT    |
            | PERMISSION_TEST_CASE_APPROVE |
            | PERMISSION_TEST_RUN_ASSIGNMENT_EXECUTE |
        And I add the role with name "Approvationalist" to the user with that name
        When the user with that name creates a new testcase with name "Passing tc"
        And when I add these steps to the testcase with that name:
            | name      | stepNumber | estimatedTimeInMin | instruction    | expectedResult        |
            | Mockery   | 1          | 5                  | Go this way    | They went this way    |
        When the user with that name creates a new testcase with name "Another Passing tc"
        And when I add these steps to the testcase with that name:
            | name      | stepNumber | estimatedTimeInMin | instruction    | expectedResult        |
            | Mockery   | 1          | 5                  | Go this way    | They went this way    |
        When the user with that name creates a new testcase with name "Failing tc"
        And when I add these steps to the testcase with that name:
            | name      | stepNumber | estimatedTimeInMin | instruction    | expectedResult        |
            | Mockery   | 1          | 5                  | Go this way    | They went this way    |
        When the user with that name creates a new testcase with name "Skipper"
        And when I add these steps to the testcase with that name:
            | name      | stepNumber | estimatedTimeInMin | instruction    | expectedResult        |
            | Mockery   | 1          | 5                  | Go this way    | They went this way    |
        When the user with that name creates a new testcase with name "Invalidisimo"
        And when I add these steps to the testcase with that name:
            | name      | stepNumber | estimatedTimeInMin | instruction    | expectedResult        |
            | Mockery   | 1          | 5                  | Go this way    | They went this way    |
        Then when I create a new user with name "Joe Tester"
        And I activate the user with that name
        And I add the role with name "Approvationalist" to the user with that name
        And when the user with name "Joe Tester" approves the following testcases:
            | name               |
            | Passing tc         |
            | Another Passing tc |
            | Failing tc         |
            | Skipper            |
            | Invalidisimo       |
        And I activate the following testcases
            | name               |
            | Passing tc         |
            | Another Passing tc |
            | Failing tc         |
            | Skipper            |
            | Invalidisimo       |
        And I create the following new testsuites:
            | name          | description               | product name | useLatestVersions |
            | Sweet Suite   | Ahh, the cycle of life... | Cortexiphan  | true              |
        And I add the following testcases to the testsuite with name "Sweet Suite":
            | name               |
            | Passing tc         |
            | Another Passing tc |
            | Failing tc         |
            | Skipper            |
            | Invalidisimo       |
        And I activate the testsuite with name "Sweet Suite"
        And when I create the following new testcycles:
            | name          | description               | product name | startDate  | endDate    | communityAuthoringAllowed | communityAccessAllowed |
            | Baroque Cycle | Ahh, the cycle of life... | Cortexiphan  | 2011/02/02 | 2012/02/02 | true                      | true                   |
        And when I create a new testrun with name "Running Man" with testcycle "Baroque Cycle"
        And I create a new environmenttype with name "EnvType1"
        And I create a new environment with name "Env1" of type "EnvType1"
        And I create a new group environmenttype with name "GrpEnvType1"
        And I create a new environmentgroup with name "EnvGrp1" of type "GrpEnvType1"
        And I add the following environments to the environmentgroup with that name:
            | name |
            | Env1 |
        And I add the following users to the testrun with that name:
            | name         |
            | Joe Tester |
        And I add the following environmentgroups to the testrun with that name:
            | name    |
            | EnvGrp1 |
        And when I add the following testsuites to the testrun with that name
            | name    |
            | Sweet Suite  |
        And I activate the testcycle with name "Baroque Cycle"
        And I activate the testrun with that name
        And I assign the following testcases to the user with name "Joe Tester" for the testrun with name "Running Man"
            | name               |
            | Passing tc         |
            | Another Passing tc |
            | Failing tc         |
            | Skipper            |
            | Invalidisimo       |
        And the user with that name marks the following testcase result statuses for the testrun with that name
            | name               | status      |
            | Passing tc         | Passed      |
            | Another Passing tc | Passed      |
            | Failing tc         | Failed      |
            | Skipper            | Skipped     |
            | Invalidisimo       | Invalidated |
        Then the following testcases have the following result statuses for that testrun
            | name               | status      |
            | Passing tc         | Passed      |
            | Another Passing tc | Passed      |
            | Failing tc         | Failed      |
            | Skipper            | Skipped     |
            | Invalidisimo       | Invalidated |
        And when I call retest only failed tests for that testrun
        Then the following testcases have the following result statuses for that testrun
            | name               | status      |
            | Passing tc         | Passed      |
            | Another Passing tc | Passed      |
            | Failing tc         | Pending     |
            | Skipper            | Skipped     |
            | Invalidisimo       | Invalidated |

    Scenario: Clone a testrun, ensure the clone has the same testcase versions as original, even if newer versions exist
        Need implementation
