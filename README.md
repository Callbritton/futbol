# Futbol

**Overview of requirements to consider:**

- Classes should be compact - no longer than 150 lines!
- Methods should be compact - no longer than 10 lines!
- Classes should have a single responsibility - must be able to describe what a class 'is' in 1 sentence.
- Incorporate Modules, Inheritance, and Plain Old Ruby Objects (POROs).
- While refactoring all existing tests must continue to pass.
- All methods MUST have an associated test.

### Our design strategy:

- We began our project by creating one large hash per data file with the header item as the key and the desired data as the value. We thought that this would be the direction we wanted to pursue due to our familiarity with hashes at the time.
- We pivoted to a more OOP solution by utilizing the rows in the csv data because we wanted to have a more dynamic solution after the realization that the data we were utilizing would not necessarily be "perfect".
- We further improved our OOP design by implementing ruby methods found in the ruby docs that were already in existence and built for csv classes.
- Finally, we refactored to incorporate a superclass, a module, and mocks/stubs to help DRY up our code.

- Please see google folder for additional design, organization, and details:
https://drive.google.com/drive/folders/1yDzZQa7386ln5oROzpTEqmEr3ZfRGbb1
