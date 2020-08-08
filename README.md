# hibernate-orm-tck
Scripts for running standalone Jakarta JPA TCK using Hibernate ORM

Prerequisites:

1. ${JAVA_HOME} must be set.

2. In base-ts.jte, the value for ${tck.home} must be set to the top-level directory path.
   (e.g, tck.home=/home/gbadner/git/hibernate-orm-tck)

3. In build.gradle, set ${hibernateVersion} to the Hibernate ORM version to be tested.
   (e.g., hibernateVersion = '5.3.18.Final')


Download derby and ant:
    sh ./download.sh

Setup and run the TCK:

    # Setup Derby database; Hibernate-specific Derby DDL script is used.
    # There may be java.sql.SQLSyntaxErrorException shown for DROP statements. These may be safely ignored.
    sh ./setupDerby.sh

    # Run the tests
    sh ./runSigTests
    sh ./runOrmTests
    
    The logs can be found in: hibernate-orm-tck/logging/

    The TCK report can be found in: hibernate-orm-tck/persistence-tck/tmp/JTreport/

To rerun the TCK:

    # Stop the Derby database:
    sh ./stopDerby
    
    Follow steps listed for "Setup and run the TCK:".

