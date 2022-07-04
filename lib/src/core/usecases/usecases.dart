abstract class UseCases<T, P> {
  Future<T> call({P params});
  // call method with return type T & takes parameter to call that method is P
  // This is the representation of our Use Cases, and this abstracted class takes a type T and params P..
  // The type is what the “call” method will return, and
  //the params is the parameters that the “call” may require (can be set to void if no params are required)
}
