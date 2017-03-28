class DocsController < ApplicationController
  before_action :find_doc, only: [:show, :edit, :update, :destroy]

  def index
    @docs = Doc.where(user_id: current_user)
  end

  def show
  end

  def new
    @doc = current_user.docs.build
  end

  def create
    @doc = current_user.docs.build(doc_params)
    if @doc.save
      flash[:notice] = "Documento guardado"
      redirect_to @doc
    else
      flash[:alert] = "Hubo un error al guardar el documento"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @doc.update(doc_params)
      flash[:notice] = "Documento actualizado"
      redirect_to @doc
    else
      flash[:alert] = "Hubo un error al actualizar el documento"
      render 'edit'
    end
  end

  def destroy
    if @doc.destroy
      flash[:notice] = "Documento eliminado"
      redirect_to docs_path
    else
      flash[:alert] = "Hubo un error al eliminar el documento"
      redirect_to docs_path
    end
  end

  private
    def find_doc
      @doc = Doc.find(params[:id])
    end

    def doc_params
      params.require(:doc).permit(:title, :content)
    end
end
