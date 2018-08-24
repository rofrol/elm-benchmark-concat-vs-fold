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
                |> Debug.log "letters"

        sampleArray =
            List.range 1 100
                |> List.map (\i -> List.map (\l -> ( i, l )) letters)
    in
    describe "concat vs foldl"
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
        ]
