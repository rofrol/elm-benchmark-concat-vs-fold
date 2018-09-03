module Main exposing (main)

import Benchmark exposing (..)
import Benchmark.Runner exposing (BenchmarkProgram, program)
import Char


main : BenchmarkProgram
main =
    program suite


suite : Benchmark
suite =
    let
        letters =
            List.range (Char.toCode 'a') (Char.toCode 'z')
                |> List.map (\i -> Char.fromCode i |> String.fromChar)

        sampleArray =
            List.range 1 100
                |> List.map (\i -> List.map (\l -> ( i, l )) letters)

        concatPlusPlus =
            List.foldr (++) []
    in
    describe "concat vs fold"
        [ Benchmark.compare "concat vs foldl"
            "concat"
            (\_ -> List.concat sampleArray)
            "foldl"
            (\_ -> List.foldl (\i acc -> i ++ acc) [] sampleArray)
        , Benchmark.compare "concat vs foldr"
            "concat"
            (\_ -> List.concat sampleArray)
            "foldr"
            (\_ -> List.foldr (\i acc -> i ++ acc) [] sampleArray)
        , Benchmark.compare "concat vs concatPlusPlus"
            "concat"
            (\_ -> List.concat sampleArray)
            "concatPlusPlus"
            (\_ -> concatPlusPlus sampleArray)
        ]
