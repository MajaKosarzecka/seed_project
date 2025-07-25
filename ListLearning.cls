public class ListLearning {
  public static void task1() {
    List<String> FruitList = new List<String>{'Apple', 'Banana', 'Cherry'};
    for (String fruit : FruitList) {
      System.debug(fruit);
    }
    FruitList.add('DragonFruit');
    System.debug(FruitList[FruitList.size() - 1]);
/*
1. Initialize a new list that will store text values. Initialize it with the following values: "Apple", "Banana", "Cherry"
    (the task is not about initializing and then adding the values!).
2. Print the values stored in the list, one by one, in the console.
3. Add a "Dragonfruit" value to the list.
4. Use a method to print just the new value in the console (last item of the list). 
5. Run the code in the developer console and filter to only see the printed texts.
*/

  }

  public static void task2() {
    List<String> stored = new List<String>{null, null, null};
    stored[1] = 'Cats';
    stored.add('Dogs');
    System.debug(stored);
/*
1. Initialize a new list that will store string values and has 3 empty slots.
2. On index 1 add a new value "Cats".
3. In a new, 4th slot add a value "Dogs".
4. Use a method to print the list in one line.
*/

  }

  public static void task3_ifelse(){
    Integer currentMonth = 7;
    List<Integer> winter = new List<Integer>{12, 1, 2};
    List<Integer> spring = new List<Integer>{3, 4, 5};
    List<Integer> summer = new List<Integer>{6, 7, 8};
    List<Integer> autumn = new List<Integer>{9, 10, 11};

     if (winter.contains(currentMonth)) {
            System.debug('It’s winter');
        } else if (spring.contains(currentMonth)) {
            System.debug('It’s spring');
        } else if (summer.contains(currentMonth)) {
            System.debug('It’s summer');
        } else if (autumn.contains(currentMonth)) {
            System.debug('It’s autumn');
        } else {
            System.debug('Invalid month');
        }
  }
/*
1.	Initialize a variable called "currentMonth" and assign a value between 1 and 12.
2.	Write a code that will print:
a.	"It’s winter" if the value is 12, 1 or 2
b.	"It’s spring" if the value is 3, 4 or 5
c.	"It’s summer" if the value is 6, 7 or 8
d.	"It’s autumn" if the value is 9, 10 or 11
The code can be written with either if/else if statements or with switch statement.
Write both versions.
You can use lists to store the possible values for the if/else if version. 
Remember about error handling.
 */
  

   public static void task3_switch(){
    Integer currentMonth = 7;
    List<Integer> winter = new List<Integer>{12, 1, 2};
    List<Integer> spring = new List<Integer>{3, 4, 5};
    List<Integer> summer = new List<Integer>{6, 7, 8};
    List<Integer> autumn = new List<Integer>{9, 10, 11};

   switch on currentMonth {
      when 12, 1, 2 {
        System.debug('It’s winter');
      }
      when 3, 4, 5 {
        System.debug('It’s spring');
      }
      when 6, 7, 8 {
        System.debug('It’s summer');
      }
      when 9, 10, 11 {
        System.debug('It’s autumn');
      }
      when else {
        System.debug('Invalid month');
      }
   }

   }
}