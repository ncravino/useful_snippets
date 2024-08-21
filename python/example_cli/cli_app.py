
import typer
from typing_extensions import Annotated, List

def example_cli(
    required_unnamed_argument: Annotated[str, typer.Argument(help="This is a required unnamed argument without a default")],
    required_named: Annotated[float, typer.Option(help="This is a required named argument")],
    unnamed_argument: Annotated[int, typer.Argument(help="This is a required unnamed argument with a default")] = 42,
    named: Annotated[int, typer.Option(help="This is a named argument passed with a default")] = 42.42,
):
    print(f"required_unnamed_argument: {required_unnamed_argument}")
    print(f"required_named: {required_named}")
    print(f"unnamed_argument: {unnamed_argument}")
    print(f"named: {named}")


example_app = typer.Typer()
example_app.command()(example_cli)


if __name__ == "__main__":
    example_app()
