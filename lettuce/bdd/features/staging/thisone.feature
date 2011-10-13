Feature: Staging area for just one tests

    Scenario: Verify results of a testrun, when changed, have the same url
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
        Then when I create a new user with name "Joe Tester"
        And I activate the user with that name
        And I add the role with name "Approvationalist" to the user with that name
        And when the user with name "Joe Tester" approves the following testcases:
            | name               |
            | Passing tc         |
        And I activate the following testcases
            | name               |
            | Passing tc         |
        And I create the following new testsuites:
            | name          | description               | product name | useLatestVersions |
            | Sweet Suite   | Ahh, the cycle of life... | Cortexiphan  | true              |
        And I add the following testcases to the testsuite with name "Sweet Suite":
            | name               |
            | Passing tc         |
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
        And I add the following environmentgroups to the testrun with that name:
            | name    |
            | EnvGrp1 |
        And when I add the following testsuites to the testrun with that name
            | name    |
            | Sweet Suite  |
        And I add the following users to the testrun with that name:
            | name         |
            | Joe Tester |
        And I activate the testcycle with name "Baroque Cycle"
        And I activate the testrun with that name
        And I assign the following testcases to the user with name "Joe Tester" for the testrun with name "Running Man"
            | name               |
            | Passing tc         |
        And I remember the URL for the result for the testcase with name "Passing tc" for that testrun
        And the user with that name marks the following testcase result statuses for the testrun with that name
            | name               | status      |
            | Passing tc         | Passed      |
        Then the URL for the result for that testcase for that testrun has not changed
