import pytest
import mock
import salmonet2_ortholog_mapper


parameters = ["example_files/test.txt", "example_files/output.mitab"]


@mock.patch.object(salmonet2_ortholog_mapper, 'parse_args')
def test_input_not_file_exists(args):
    with pytest.raises(SystemExit) as pytest_wrapped_e:
        args.return_value = ['file', False, False, True, parameters[1]]
        salmonet2_ortholog_mapper.main()

    assert pytest_wrapped_e.type == SystemExit
    assert pytest_wrapped_e.value.code == 1


@mock.patch.object(salmonet2_ortholog_mapper, 'parse_args')
def test_mapper_file_not_exists(args):
    with pytest.raises(SystemExit) as pytest_wrapped_e:
        args.return_value = [parameters[0], 'file', False, True, parameters[1]]
        salmonet2_ortholog_mapper.main()

    assert pytest_wrapped_e.type == SystemExit
    assert pytest_wrapped_e.value.code == 2


@mock.patch.object(salmonet2_ortholog_mapper, 'parse_args')
def test_ortholog_file_not_exists(args):
    with pytest.raises(SystemExit) as pytest_wrapped_e:
        args.return_value = [parameters[0], False, 'file', True, parameters[1]]
        salmonet2_ortholog_mapper.main()

    assert pytest_wrapped_e.type == SystemExit
    assert pytest_wrapped_e.value.code == 3


@mock.patch.object(salmonet2_ortholog_mapper, 'parse_args')
def test_lines_number_in_the_output(args):
    args.return_value = [parameters[0], False, False, True, parameters[1]]
    salmonet2_ortholog_mapper.main()

    lines_in_output = sum(1 for line in open(parameters[1]))

    assert lines_in_output == 7


@mock.patch.object(salmonet2_ortholog_mapper, 'parse_args')
def test_information_in_the_output(args):
    args.return_value = [parameters[0], False, False, True, parameters[1]]
    salmonet2_ortholog_mapper.main()

    with open(parameters[1], 'r') as output:

        for line in output:
            line = line.strip().split('\t')

            assert line[0].split(":")[1][:5] == line[1].split(":")[1][:5]
            assert "ECOLI" not in line[0]
            assert "ECOLI" not in line[1]
