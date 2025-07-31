public class CatTest {
    @IsTest
    static void catName() {
        Cat cat = new Cat('Maciek')
        System.assertEquals('Maciek', cat.name);
        System.assertEquals(null, cat.birthYear);
        System.assertEquals(null, cat.color);
    }

    @IsTest
    static void catNameBirthYearColor() {
        Cat cat = new Cat('Maciek', 2020, 'black')
        System.assertEquals('Maciek', cat.name);
        System.assertEquals(2020, cat.birthYear);
        System.assertEquals('black', cat.color);
        System.assertEquals(null, cat.owner);
    }

    @IsTest
    static void catNameBirthYearColorOwner() {
        Cat cat = new Cat('Maciek', 2020, 'black', 'Maja')
        System.assertEquals('Maciek', cat.name);
        System.assertEquals(2020, cat.birthYear);
        System.assertEquals('black', cat.color);
        System.assertEquals('Maja', cat.owner);
    }
   
    @isTest
    static void adoptCatWhichalreadyHasAnOwner() {
        Cat cat = new Cat('Kicia', 2020, 'black');
        Boolean result = cat.adoptCat('Ania');
        System.assertEquals(true, result, 'Cat should be adopted');
        System.assertEquals('Ania', cat.owner);
    }

    @isTest
    static void adoptCatWhichalreadyHasAnOwner() {
        Cat cat = new Cat('Kicia', 2020, 'black', 'Maja');
        Boolean result = cat.adoptCat('Ania');
        System.assertEquals(false, result, 'should not be able to adopt a cat which already has an owner');
        System.assertEquals('Maja', cat.owner);
    }

    @isTest
    static void callCatWithoutName() {
        Cat cat = new Cat('Lusia');
        String response = cat.callCat();
        System.assertEquals('Cat ignored you', response);
    }

    @isTest
    static void callCatWithValidName() {
        Cat cat = new Cat('Lusia');
        String response = cat.callCat('Lusia');
        System.assertEquals('Cat is on its way', response);
    }

    @isTest
    static void callCatWithInvalidName() {
        Cat cat = new Cat('Lusia');
        String response = cat.callCat('Maciek');
        System.assertEquals('Cat ignored you', response);
    }

    @isTest
    static void catAgeNull() {
        Cat cat = new cat('Kicia');
        String response = cat.checkCatsAge();
        System.assertEquals('Birth year not set', response);
    }

    @isTest
    static void checkcatAge() {
        Integer currentYear = Date.today();
        Cat cat = new cat('Kicia', currentYear - 7, 'black');
        String response = cat.checkCatsAge();
        System.assertEquals(7, response);
    }

    @isTest
    static void meowTest() {
        Cat.meow();
        System.assert(true, 'meow is static');
    }
}