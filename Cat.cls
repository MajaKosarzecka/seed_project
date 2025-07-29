public with sharing class Cat {
    public String name;
    public Integer birthYear;
    public String color;
    public String owner;

    public Cat(String name) {
        this.name = name 
    }

    public Cat(String name, Integer birthYear, String color) {
        this.name = name;
        this birthYear = birthYear;
        this.color = color;

    }

    public Cat(String name, Integer birthYear, String color, String owner) {
        this.name = name;
        this.birthYear = birthYear;
        this.color = color;
        this.owner = owner;
    }

    public Boolean adoptCat(String ownerName) {
        if (this.owner == null) {
            this.owner = ownerName;
            return true;
        } else {
            System.debug('Cat already has an owner: ' + this.owner);
            return false;
        }
    }

    public String callCat(String catName) {
        if (this.name == catName) {
            return 'Cat is on its way';
        } else {
            return 'Cat ignored You';
        }
    }

    public Integer checkCatsAge() {
        if (this.birthYear != null) {
            Integer currentYear = Date.today().year();
            return currentYear - this.birthYear;
        } else {
            System.debug('Birth year not set');
            return null;
        }
    }

    public static void meow() {
        System.debug('Meow');
    }




    /*
    You can make a Dog class if You prefer :) If You do that, follow the instruction by replacing Cat with Dog
    1. There should be three ways to construct a cat:
        - one with just a name
        - one with a name, birth year and color
        - one with a name, birth year, color and the cat's owner's name
    (look up constructor chaining or constructor overloading in Apex)
    2.  create a non static method called adoptCat
        - input parameter: ownerName
        - the method should assign a new value to the owner property of the cat instance, but only if the cat has no owner yet
            If the owner is already set, print a message informing about the issue and return false
            If the "adoption" is successful, return true  
    3. Create a non static method called callCat. 
        - input parameter: catName
        - if the passed parameter matches the cat instance's name (the value stored in the name variable), return 'Cat is on its way' string
        - if the passed parameter doesn't match, return 'Cat ignored You' string
    4. Create a non static method call checkCatsAge. 
        - if the cat instance has a value assigned to the age variable, calculate the cat's age by subtracting the birthYear from the current year
        (make sure that the current year value will be valid in the future too, don't use static value like 2025)
    5. Create a static method called meow. It should print "Meow" and not return anything.
    6. - Try to invoke all of the methods. Note the difference between invoking static and non static methods. 
    */
}

public static void demo() {
    // Example usage of the Cat class
    Cat myCat = new Cat('Kicia', 2010, 'black', 'Maja'); // Non static instance with creating an instance
        myCat.adoptCat('Maja');
        myCat.callCat('Kicia');
        myCat.checkCatsAge();
        meow();

    Cat.meow(); //Static without creating an instance
}