//
//  Result
//  Clifit Demo
//
//  Created by YADU MADHAVAN on 02/08/20.
//  Copyright © 2020 Uvionics. All rights reserved.
//

import Foundation

enum Result<T, E> where E: Error {
    case success(T)
    case failure(E)
}
